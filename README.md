#  Proxy login SSH Script

- Support login with proxy

> I know SSH config, this script is for my multi-device sync, lazy but not full lazy :)
>
> Maybe it can be do more thing

## Usage

1. Edit `example.sh` , input your server name, username, host, port
2. Save `bash ./example.sh` or `./example.sh` 

If you need proxy you can edit proxy config in `example.sh`

## Require

- `SSH Client` : support `-o` args
- `nc` or `ncat` (aka Netcat)

### How to found Netcat?

Any OS can get ncat from [Nmap - Ncat (Recommend)](https://nmap.org/ncat/) .

MacOS can install `netcat` from brew or other package manager.

Linux can install `netcat` from apt or other package manager.

> What kind of waste of time am I doing again !? :(