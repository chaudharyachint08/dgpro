# load additional Python module
import socket
import numpy as np


# One Server, multiple client as each peer node

class PeerNode:
    def __init__(self,other_peers=2):
        'At least 2 other peers are assumed'
        # create TCP/IP socket
        self.server_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.client_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            while:
                server_port = np.randint(1024,65536)
                server_address = (self.get_public_ip(),server_port)
                self.server_sock.bind(server_address)
        except:
            pass
        else:
            break
        server_sock.bind(server_address)


    def get_public_ip(self)
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        val = s.getsockname()[0]
        s.close()
        return val
    
    def send(self,message):
        pass
    
    def receive(self)