FROM pearlhub/doc-dev:latest

# # Uncomment the following to use git in the container.
# # Prerequisite: step 9 in the README instructions.
# #### BEGIN
# ARG ssh_prv_key

# # Add the keys and set permissions
# # Do not upload image anywhere!
# RUN mkdir -p /root/.ssh
# RUN chmod 700 /root/.ssh
# RUN echo "$ssh_prv_key" > /root/.ssh/id_ed25519-docker && \
#     echo "\n" >> /root/.ssh/id_ed25519-docker
# RUN chmod 600 /root/.ssh/id_ed25519-docker
# #### END