FROM jenkins/jenkins:2.282-jdk11

USER root

# install docker to be able run docker commands
RUN apt-get -qq update \
   && apt-get -qq -y install curl
RUN curl -sSL https://get.docker.com/ | sh
RUN usermod -a -G staff jenkins

USER jenkins

RUN /usr/local/bin/install-plugins.sh \
    generic-webhook-trigger \
    configuration-as-code \
    git git-parameter cloudbees-folder ws-cleanup timestamper mailer email-ext \
    docker-workflow docker-plugin \
    job-dsl pipeline-stage-view pipeline-utility-steps \
    authorize-project \
    envinject \
    ssh-steps \
    ant nodejs \
    antisamy-markup-formatter ldap build-timeout gradle \
    pipeline-milestone-step pipeline-build-step pipeline-github-lib \
    lockable-resources jjwt-api okhttp-api \
    github github-api github-branch-source \
    ssh-slaves matrix-auth pam-auth email-ext

# add configuration as a code file
COPY --chown=jenkins casc_jenkins.yaml /var/casc_jenkins.yaml
RUN chmod 755 /var/casc_jenkins.yaml

ENV CASC_JENKINS_CONFIG=/var/casc_jenkins.yaml
