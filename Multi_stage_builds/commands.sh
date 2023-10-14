mvn archetype:generate -DgroupId=com.clarus.maven -DartifactId=myproject -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
# Add the following lines to the pom.xml file
# <build>
#   <plugins>
#     <plugin>
#       <groupId>org.apache.maven.plugins</groupId>
#       <artifactId>maven-assembly-plugin</artifactId>
#       <executions>
#           <execution>
#               <phase>package</phase>
#               <goals>
#                   <goal>single</goal>
#               </goals>
#               <configuration>
#                   <archive>
#                   <manifest>
#                       <mainClass>
#                           com.clarus.maven.App
#                       </mainClass>
#                   </manifest>
#                   </archive>
#                   <descriptorRefs>
#                       <descriptorRef>jar-with-dependencies</descriptorRef>
#                   </descriptorRefs>
#               </configuration>
#           </execution>
#       </executions>
#     </plugin>
#   </plugins>
# </build>
docker build -t maven-project .
docker run maven-project
# Hello World!