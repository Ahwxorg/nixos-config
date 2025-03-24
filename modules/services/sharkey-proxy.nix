{ ... }:
{
  services = {
    nginx.virtualHosts."quack.social" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-Proto https;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Host $remote_addr;
        '';
      };

      locations."/files/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-Proto https;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Host $remote_addr;
          
          # Try cache?
          # proxy_cache sharkey;
          # proxy_cache_path /var/cache/nginx/sharkey levels=1:2 keys_zone=sharkey:15m;
          # proxy_cache_lock on;
          # proxy_cache_use_stale updating;
          # proxy_force_ranges on;
          # add_header X-Cache $upstream_cache_status;
        '';
      };

      locations."/wiki/" = {
        # Nepenthis
        proxyPass = "http://localhost:8893";
        extraConfig = ''
          proxy_set_header X-Prefix '/wiki';
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-Proto https;
          proxy_set_header X-Forwarded-For $remote_addr;
          proxy_set_header X-Forwarded-Host $remote_addr;
          proxy_buffering off;
        '';
      };
    };
  };
}
