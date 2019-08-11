'''
https://developers.google.com/drive/api/v3/folder
https://developers.google.com/drive/api/v3/about-auth#what-scope-or-scopes-does-my-app-need?
https://developers.google.com/drive/api/v3/search-files
https://developers.google.com/drive/api/v3/reference/files/list
'''

import os, pickle, io
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
from googleapiclient.http import MediaFileUpload, MediaIoBaseDownload


class GDrive:
    'Class definition for GDrive REST API v3 functions for datasets handling'
    def __init__(self):
        # If modifying these scopes, delete the file token.pickle.
        self.SCOPES = ['https://www.googleapis.com/auth/drive']

        # Used for getting drive_folder_name to drive_folder_id
        self.gd_name_to_id = {'.':None} # Drive Folder when Nowhere has None as ID

        """Shows basic usage of the Drive v3 API.
        Prints the names and ids of the first 10 files the user has access to.
        """
        creds = None
        # The file token.pickle stores the user's access and refresh tokens, and is
        # created automatically when the authorization flow completes for the first
        # time.
        if os.path.exists('token.pickle'):
            with open('token.pickle', 'rb') as token:
                creds = pickle.load(token)
        # If there are no (valid) credentials available, let the user log in.
        if not creds or not creds.valid:
            if creds and creds.expired and creds.refresh_token:
                creds.refresh(Request())
            else:
                flow = InstalledAppFlow.from_client_secrets_file(
                    'credentials.json', self.SCOPES)
                creds = flow.run_local_server(port=0)
            # Save the credentials for the next run
            with open('token.pickle', 'wb') as token:
                pickle.dump(creds, token)
        self.drive_service = build('drive', 'v3', credentials=creds)

    def mkdir(self,name):
        'Creating a folder in My Drive for storage management'
        file_metadata = { 'name': name, 'mimeType': 'application/vnd.google-apps.folder' }
        file = self.drive_service.files().create(body=file_metadata,fields='id').execute()
        self.gd_name_to_id[name] = file.get('id')
        # print('Folder Created with ID: %s' % file.get('id'))

    def move_to_dir(self,file_id,folder_id):
        'make file child of given directory'
        # Retrieve the existing parents to remove
        file = self.drive_service.files().get(fileId=file_id,
                                         fields='parents').execute()
        previous_parents = ",".join(file.get('parents'))
        # Move the file to the new folder
        file = self.drive_service.files().update(fileId=file_id,
                                            addParents=folder_id,
                                            fields='id, parents',
                                            **({'removeParents':previous_parents} if file.get('parents') else {}),
                                            ).execute()

    def remove(self,id): 
        'Removing a file (or folder-file) from GDrive'
        self.drive_service.files().delete( fileId=id ).execute()

    def find_dir(self,dir_name):
        'Find given directory in GDrive and if exist, set it in gd_name_to_id'
        results = self.drive_service.files().list(q="mimeType='application/vnd.google-apps.folder'",
        	fields="nextPageToken, files(id, name)").execute()
        items = results.get('files', [])
        for item in items:
            if item['name'] == dir_name:
                file_id, file_name = item['id'], item['name']
                self.gd_name_to_id[file_name] = file_id
                return True
        return False

    def find_file(self,file_name,drive_path_id=None):
        'Find given file [in directory] in GDrive and if exist, set it in gd_name_to_id'
        results = self.drive_service.files().list(fields="nextPageToken, files(id, name)",
        	**({} if drive_path_id is None else {'q':"%s in parents"%repr(drive_path_id)})).execute()
        items = results.get('files', [])
        for item in items:
            if item['name'] == file_name:
                file_id, file_name = item['id'], item['name']
                self.gd_name_to_id[file_name] = file_id
                return True
        return False

    def download(self,drive_name,disk_name=None,drive_path_id=None,disk_path='.'):
        'Downloader from GDrive'
        if disk_name is None:
            disk_name = drive_name
        results = self.drive_service.files().list(fields="nextPageToken, files(id, name)",
            **({} if drive_path_id is None else {'q':"%s in parents"%repr(drive_path_id)})
            ).execute()
        items = results.get('files', [])
        for item in items:
            # print(u'{0} ({1})'.format(item['name'], item['id']))
            if item['name'] == drive_name:
                file_id, file_name = item['id'], item['name']
                self.gd_name_to_id[file_name] = file_id
                break
        else:
            print('File Not Found',drive_name)
            return
        request = self.drive_service.files().get_media(fileId=file_id)
        with io.FileIO(os.path.join(disk_path,disk_name),'wb') as fh:
            downloader = MediaIoBaseDownload(fh, request)
            while True:
                status, done = downloader.next_chunk()
                print("Download %d%%." % int(status.progress() * 100))
                if done:
                    break

    def upload(drive_name,disk_name=None,drive_path_id=None,disk_path='.'):
        'Uploader for GDrive'
        if disk_name is None:
            disk_name = drive_name
        file_metadata = {'name': drive_name}
        if drive_path_id is not None:
            file_metadata.update({'parents': [drive_path_id]})
        media = MediaFileUpload(os.path.join(disk_path,disk_name),mimetype='text/csv', resumable=True)
        file = self.drive_service.files().create(body=file_metadata,
                                            media_body=media,
                                            fields='id').execute()
        self.gd_name_to_id[drive_name] = file.get('id')
        # print('File ID: %s' % file.get('id'))


if __name__ == '__main__':
    disk_path,  disk_name  = '.', 'data.csv'
    drive_path, drive_name = 'datasets', 'data.csv'

    GDrive_obj = GDrive()

    if (drive_path != '.') and (not GDrive_obj.find_dir(drive_path)):
        GDrive_obj.mkdir(drive_path)
    if GDrive_obj.find_file(drive_name,GDrive_obj.gd_name_to_id[drive_path]):
	    GDrive_obj.remove(GDrive_obj.gd_name_to_id[drive_name])

    GDrive_obj.upload (  drive_name,disk_name,GDrive_obj.gd_name_to_id[drive_path],disk_path )
    GDrive_obj.download( drive_name,disk_name,GDrive_obj.gd_name_to_id[drive_path],disk_path )
    GDrive_obj.remove(   GDrive_obj.gd_name_to_id[drive_name] )