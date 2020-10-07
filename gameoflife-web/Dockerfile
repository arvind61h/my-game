FROM tomcat:8-jre8
RUN rm -rf webapps && mv -rf webapps.dist webapps
COPY ./gameoflife.war webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
