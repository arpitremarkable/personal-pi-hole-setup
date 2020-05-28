# pihole_release-v5.0.dockerfile
FROM pihole/pihole:latest

RUN echo "release/v5.0" | sudo tee /etc/pihole/ftlbranch && \
    echo y | pihole checkout core release/v5.0 && \
    echo y | pihole checkout web release/v5.0 && \
    sed -i 's/readonly //g' /opt/pihole/webpage.sh && \
    sed -i '/^WEBPASSWORD/d' /etc/pihole/setupVars.conf && \
    sed -i $'s/helpFunc() {/unsupportedFunc() {\\\n  echo "Function not supported in Docker images"\\\n  exit 0\\\n}\\\n\\\nhelpFunc() {/g' /usr/local/bin/pihole && \
    sed -i $'s/)\s*updatePiholeFunc/) unsupportedFunc/g' /usr/local/bin/pihole  