import os, hashlib
c = get_config()
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.port = 8888
c.NotebookApp.open_browser = False
c.NotebookApp.password = 'sha1:abcd:' + hashlib.sha1(os.getenv('PASSWORD', 'changeme').encode() + b'abcd').hexdigest()