# Data Exfilitation through Citrix Printer Redirection 
This was an idea we implemented during an engagement back in 2017 to exfiltrate data from a hardened Citrix XenApp environment through client printer redirection, i.e. client printers can be mapped to a Citrix session. When client printing is permitted we can use the printer metadata to copy data to or from an "isolated" virtualised desktop back to the client. 

The attack works like this:
1. Client sets up a printer locally;
2. A Citrix session is established by the client;
3. If client printing is permitted the printer is now available on the "virtualised desktop";
4. The "printer comments" metadata on the shared printer is used to write data;
5. The metadata becomes visible to the client where it can be copied off;
6. Rinse & Repeat;

The proof of concept breaks down a file into bytes and then creates a loop to copy the data over in chunks. The same concept can be used to copy tools and scripts over for further recon/exploitation.

There can be a slight delay between writing the data on the virtualised desktop and receiving it on the client side, there is also a limit on the number of bytes you send per change, so it's probably not going to let send or receive large data chunks.

Credit: Mansour Al-Zayani (MZ) for implementing the idea and writing a large portion of the code.

Reported to Citrix 18 Feb 2017.
