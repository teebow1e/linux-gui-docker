# ------------------------------------------------------------------------------
# Pull base image
FROM ubuntu:22.04

# ------------------------------------------------------------------------------
# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV WINDOWMANAGER=xfce4
ENV LANG=C
ENV TZ=Asia/Ho_Chi_Minh

# ------------------------------------------------------------------------------
# Install tigervnc, xfce4
RUN apt-get update

RUN apt-get install -y --no-install-recommends \
      adwaita-icon-theme-full \
      ca-certificates \
      curl \
      wget \
      dbus-x11 \
      fbpanel \
      hsetroot \
      less \
      locales \
      vim \
      sudo \
      tigervnc-common \
      tigervnc-standalone-server \
      tigervnc-tools \
      tzdata \
      xterm \
      x11-utils \
      x11-xserver-utils \
      xfce4 \
      xfce4-goodies \
      xfonts-base

# ------------------------------------------------------------------------------
# Install development packages (add more if needed)
RUN apt-get install -y --no-install-recommends \
        net-tools \
        htop \
        tree \
        python3-pip \
        unzip \
        file \
        git

# ------------------------------------------------------------------------------
# Perform clean-up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Configure locale
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen

# ------------------------------------------------------------------------------
# Install scripts and configuration files
COPY app/app.sh app/imagestart.sh app/tiger.sh app/novnc.sh /app/
COPY wallpaper/wallpaper.png /tmp/wallpaper.png
COPY conf/xstartup /usr/share/ubuntu-desktop/vnc/
COPY conf/sudo /usr/share/ubuntu-desktop/sudo
COPY conf/bash.colors conf/color_prompt.sh /opt/bash/
COPY novnc/novnc_redirect.html /tmp/novnc_redirect.html
COPY scripts/ /app/scripts/

# ------------------------------------------------------------------------------
# Install xfce4 scripts and configuration files
COPY xfce4/* /root/.config/autostart/

# ------------------------------------------------------------------------------
# Create a symbolic link to the scripts folder
RUN ln -s /app/scripts/ /scripts
RUN chmod -R 755 /app/scripts/

# ------------------------------------------------------------------------------
# Define default command
ENTRYPOINT ["/app/app.sh"]
