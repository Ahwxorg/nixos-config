{ ... }:
{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.7.0.2/24" "fddd:2c4:2c4:2c4::2/64" ];
      dns = [ "9.9.9.9" "149.112.112.112" ];
      privateKeyFile = "/root/wireguard-keys/privatekey";
      
      peers = [{
        publicKey = "GfrFhe2JV8FS/711WAdx6CLF/QIEj1KoOGP/ErxBHkg=";
        presharedKeyFile = "/root/wireguard-keys/preshared_from_peer0_key";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        endpoint = "57.129.46.171:51820";
        persistentKeepalive = 25;
      }];
    };
  };
}
