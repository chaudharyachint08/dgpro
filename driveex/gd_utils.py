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

# If modifying these scopes, delete the file token.pickle.
SCOPES = ['https://www.googleapis.com/auth/drive']

# Used for getting drive_folder_name to drive_folder_id
gd_name_to_id = {'.':None} # Drive Folder when Nowhere has None as ID


def init_service():
    'initiate global drive_service variable for GDrive access'
    global drive_service
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
                'credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open('token.pickle', 'wb') as token:
            pickle.dump(creds, token)
    drive_service = build('drive', 'v3', credentials=creds)

def gd_mkdir(name):
    'Creating a folder in My Drive for storage management'
    file_metadata = { 'name': name, 'mimeType': 'application/vnd.google-apps.folder' }
    file = drive_service.files().create(body=file_metadata,fields='id').execute()
    gd_name_to_id[name] = file.get('id')
    print('Folder Created with ID: %s' % file.get('id'))

def gd_move_to_dir(file_id,folder_id):
    ''
    # Retrieve the existing parents to remove
    file = drive_service.files().get(fileId=file_id,
                                     fields='parents').execute()
    previous_parents = ",".join(file.get('parents'))
    # Move the file to the new folder
    file = drive_service.files().update(fileId=file_id,
                                        addParents=folder_id,
                                        fields='id, parents',
                                        **({'removeParents':previous_parents} if file.get('parents') else {}),
                                        ).execute()

def gd_remove(id): 
    'Removing a file (or folder-file) from GDrive'
    drive_service.files().delete( fileId=id ).execute()

def find_dir(dir_name):
    'Find given directory in GDrive and if exist, set it in gd_name_to_id'
    # Call the Drive v3 API
    results = drive_service.files().list(q="mimeType='application/vnd.google-apps.folder'",
    	fields="nextPageToken, files(id, name)").execute()
    items = results.get('files', [])
    for item in items:
        if item['name'] == dir_name:
            file_id, file_name = item['id'], item['name']
            gd_name_to_id[file_name] = file_id
            return True
    return False

def find_file(file_name,drive_path_id=None):
    'Find given file [in directory] in GDrive and if exist, set it in gd_name_to_id'
    # Call the Drive v3 API
    results = drive_service.files().list(fields="nextPageToken, files(id, name)",
    	**({} if drive_path_id is None else {'q':"%s in parents"%repr(drive_path_id)})).execute()
    items = results.get('files', [])
    for item in items:
        if item['name'] == file_name:
            file_id, file_name = item['id'], item['name']
            gd_name_to_id[file_name] = file_id
            return True
    return False


def gd_download(drive_name,disk_name=None,drive_path_id=None,disk_path='.'):
    'Downloader from GDrive'
    if disk_name is None:
        disk_name = drive_name
    results = drive_service.files().list(fields="nextPageToken, files(id, name)",
        **({} if drive_path_id is None else {'q':"%s in parents"%repr(drive_path_id)})
        ).execute()
    items = results.get('files', [])
    for item in items:
        print(u'{0} ({1})'.format(item['name'], item['id']))
        if item['name'] == drive_name:
            file_id, file_name = item['id'], item['name']
            gd_name_to_id[file_name] = file_id
            break
    else:
        print('File Not Found',drive_name)
        return

    request = drive_service.files().get_media(fileId=file_id)
    with io.FileIO(os.path.join(disk_path,disk_name),'wb') as fh:
        downloader = MediaIoBaseDownload(fh, request)
        while True:
            status, done = downloader.next_chunk()
            print("Download %d%%." % int(status.progress() * 100))
            if done:
                break

def gd_upload(drive_name,disk_name=None,drive_path_id=None,disk_path='.'):
    'Uploader for GDrive'
    if disk_name is None:
        disk_name = drive_name

    file_metadata = {'name': drive_name}
    if drive_path_id is not None:
        file_metadata.update({'parents': [drive_path_id]})
    media = MediaFileUpload(os.path.join(disk_path,disk_name),mimetype='text/csv', resumable=True)
    file = drive_service.files().create(body=file_metadata,
                                        media_body=media,
                                        fields='id').execute()
    gd_name_to_id[drive_name] = file.get('id')
    print('File ID: %s' % file.get('id'))



if __name__ == '__main__':
    disk_path,  disk_name  = '.', 'data.csv'
    drive_path, drive_name = 'datasets', 'data.csv'

    init_service()

    if (drive_path != '.') and (not find_dir(drive_path)):
        gd_mkdir(drive_path)
    if find_file(drive_name,gd_name_to_id[drive_path]):
	    gd_remove(gd_name_to_id[drive_name])
    gd_upload (  drive_name,disk_name,gd_name_to_id[drive_path],disk_path )
    gd_download( drive_name,disk_name,gd_name_to_id[drive_path],disk_path )
    gd_remove(gd_name_to_id[drive_name])
