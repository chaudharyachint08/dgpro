# load additional Python module
import socket
import numpy as np


# One Server, multiple client as each peer node

class PeerNode:
	''
    def __init__(self,total_peers=2,node_name=''):
        'At least 2 other peers are assumed'
        # create TCP/IP socket
        self.peer_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            while:
                self.peer_port = np.randint(1024,65536)
                self.peer_address = (self.get_public_ip(),self.peer_port)
                self.peer_sock.bind(self.peer_address)
        except:
            pass
        else:
            break
        self.peer_sock.bind(self.peer_address)
        self.peer_sock.listen(total_peers-1)
        # GDrive Port Addresses Fetch & Update
        # create and update self.address_dict from GDrive
        self.address_dict[node_name] = self.peer_address
        
    def get_public_ip(self):
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        val = s.getsockname()[0]
        s.close()
        return val
    
    def send(self,message_dict,recv_name):
    	message_str = str(message_dict)
    
    def receive(self)