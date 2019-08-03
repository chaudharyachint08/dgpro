from __future__ import print_function
import pickle, io
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
from googleapiclient.http import MediaIoBaseUpload,MediaIoBaseDownload

# If modifying these scopes, delete the file token.pickle.
SCOPES = ['https://www.googleapis.com/auth/drive']

# Used for getting drive_folder_name to drive_folder_id
gd_name_to_id = {}

def init_service():
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
    file_metadata = { 'name': name, 'mimeType': 'application/vnd.google-apps.folder' }
    file = drive_service.files().create(body=file_metadata,fields='id').execute()
    gd_name_to_id[name] = file.get('id')
    print('Folder Created with ID: %s' % file.get('id'))

def gd_move_to_dir(file_id,folder_id):
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

def gd_download(drive_name,disk_name=None,drive_path_id=None,disk_path='.'):
    if disk_name is None:
        disk_name = drive_name
    # Call the Drive v3 API
    results = drive_service.files().list(fields="nextPageToken, files(id, name)",
        **({} if drive_path_id is None else {'q':(drive_path_id in 'parents')})).execute()
    items = results.get('files', [])
    for item in items:
        print(u'{0} ({1})'.format(item['name'], item['id']))
        if item['name'] == drive_name:
            file_id, file_name = item['id'], item['name']
            gd_name_to_id[file_name] = file_id
            break
    else:
        print('File Not Found',drive_name)

    request = drive_service.files().get_media(fileId=file_id)
    with io.FileIO(os.path.join(disk_path,disk_name),'wb') as fh:
        downloader = MediaIoBaseDownload(fh, request)
        while True:
            status, done = downloader.next_chunk()
            print("Download %d%%." % int(status.progress() * 100))
            if done:
                break

def gd_upload(drive_name,disk_name=None,drive_path_id=None,disk_path='.'):
    if disk_name is None:
        disk_name = drive_name

    file_metadata = {'name': 'photo.jpg'}
    if drive_path_id is not None:
        file_metadata.update({'parents': [folder_id]})
    media = MediaIoBaseUpload(os.path.join(disk_path,disk_name), resumable=True)
    file = drive_service.files().create(body=file_metadata,
                                        media_body=media,
                                        fields='id').execute()
    print('File ID: %s' % file.get('id'))


if __name__ == '__main__':
    disk_path,  disk_name  = '.','data.csv'
    drive_path, drive_name = '.','data.csv'
    init_service()
    if drive_path != '.':
        gd_mkdir(drive_path)
    gd_download(drive_name,drive_path,disk_name,disk_path)
    gd_upload(drive_name,drive_path,disk_name,disk_path)
