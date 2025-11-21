{ lib, ... }:
{
  services.syslogd = {
    enable = true;
    enableNetworkInput = lib.mkForce false;
    tty = "";
    defaultConfig = ''
      local1.*                     -/var/log/dhcpd

      *.=warning;*.=err            -/var/log/warn
      *.crit                        /var/log/warn

      *.*;mail.none;local1.none    -/var/log/messages

      auth,authpriv.*                 /var/log/auth.log
      *.*;auth,authpriv.none          -/var/log/syslog
      cron.*                         /var/log/cron.log
      daemon.*                        -/var/log/daemon.log
      kern.*                          -/var/log/kern.log
      lpr.*                           -/var/log/lpr.log
      mail.*                          /var/log/mail.log
      user.*                          -/var/log/user.log
      uucp.*                          -/var/log/uucp.log
      local6.debug                    /var/log/imapd.log

      mail.info                       -/var/log/mail.info
      mail.warn                       -/var/log/mail.warn
      mail.err                        /var/log/mail.err

      *.=debug;\
         auth,authpriv.none;\
         news.none;mail.none     -/var/log/debug
      *.=info;*.=notice;*.=warn;\
              auth,authpriv.none;\
              cron,daemon.none;\
              mail,news.none          -/var/log/messages
      daemon,mail.*;\
             news.=crit;news.=err;news.=notice;\
             *.=debug;*.=info;\
             *.=notice;*.=warn       /dev/tty8

      *.emerg                         *
      *.=alert                        *
    '';
  };
}
