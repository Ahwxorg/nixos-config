{ ... }:
{
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.7.0.4/24" ];
      dns = [ "9.9.9.9" "149.112.112.112" ];
      privateKeyFile = "/root/wireguard-keys/privatekey";
      
      peers = [{
        publicKey = "uE40chWhiPpnNHcgnLhMfOUfzotS6hK+dWwI1sIFcUw=";
        presharedKeyFile = "/root/wireguard-keys/preshared_from_peer0_key";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        endpoint = "213.210.34.27:58192";
        persistentKeepalive = 25;
      }];
    };
  };
}
