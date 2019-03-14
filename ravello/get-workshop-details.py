from ravello_sdk import *
import json, sys

with open('config.json') as file:
    config = json.load(file)

client = RavelloClient()
client.login(username=config['username'], password=config['password'])

print "<html><head><title>RHHI Workshop</title></head>"
print "<body>"
print "<p><a href=http://people.redhat.com/jcall/RHHI/>RHHI Workshop Lab Instructions</a></p>"
print "<p>"

with open('users.json') as file:
    users = json.load(file)
    for user in users:
        app_name = 'FEDSLED-SA-RHHI-' + user
        try:
            app = client.get_application_by_name(app_name=app_name)
        except RavelloError:
            print "Environment for \"" + user + "\" is not found!"
        else:
            for vm in client.get_vms(app=app, filter={'name':'admin'}):
                vm_fqdn = client.get_vm_fqdn(app=app, vm=vm)
                sys.stdout.write("<a href=http://" + vm_fqdn['value'] + ">" + user + " - http://" + vm_fqdn['value'] + "</a><br>" +"\n")

print "</p></body>"
print "</html>"
