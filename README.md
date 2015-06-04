# docker-mattcj-nexus
Customized nexus docker image

Extends the 'sonatype/nexus' docker image:
- modifies Http Session Management to disable ui keepAlive and reduce session length to 15 minutes. [See documentation](https://support.sonatype.com/entries/38187483-Nexus-HTTP-Session-Management) 

