FROM ubuntu
ENTRYPOINT ["echo", "hello"]
CMD [ "Joe"]
# We can override CMD instruction but we can not override ENTRYPOINT instruction

# ENTRYPOINT echo hello # Unlike CMD, ENTRYPOINT cannot be overridden. 

# CMD ["echo", "$HOME"] # Unlike the shell form, the exec form does not invoke a command shell
# CMD echo $HOME

# CMD ["echo", "hello"] 
# CMD echo "hello"