FROM fedora

# Install tools
RUN dnf install -y rpm-build rpmdevtools rpmautospec wget git

# Setup the RPM build tree
RUN rpmdev-setuptree

# Download sources
WORKDIR /root/rpmbuild/SOURCES
RUN wget $(spectool -S /project/swingfx-core.spec 2>/dev/null | grep Source0 | cut -d" " -f 2)

# Generate specfile with correct versioning
WORKDIR /project
RUN git config --global --add safe.directory /project
RUN git status
RUN rpmautospec process-distgit swingfx-core.spec /root/rpmbuild/SPECS/swingfx-core.spec

# Copy sources
RUN cp -rf /project/* /root/rpmbuild/SOURCES
RUN rm /root/rpmbuild/SOURCES/swingfx-core.spec

WORKDIR /root/rpmbuild

# Run container until stopped
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
