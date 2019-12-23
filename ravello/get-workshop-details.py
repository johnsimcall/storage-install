from ravello_sdk import *
import json, sys

with open('config.json') as file:
    config = json.load(file)

client = RavelloClient()
client.login(username=config['username'], password=config['password'])
appName = config['appName']
users = config['users']
vmName = "server1"

print "<html><head><title>Red Hat Workshop</title></head>"
print "<body>"
print "<p><a href=http://people.redhat.com/jcall/cockpit-slides.pdf>Workshop Lab Instructions</a></p>"
print "<p>"
for user in users:
    app_name = appName + user
    try:
        app = client.get_application_by_name(app_name=app_name)
    except RavelloError:
        print "Environment for \"" + user + "\" is not found!"
    else:
        for vm in client.get_vms(app=app, filter={'name':vmName}):
            vm_fqdn = client.get_vm_fqdn(app=app, vm=vm)
            sys.stdout.write("<a href=http://" + vm_fqdn['value'] + ":9090>" + user + " - http://" + vm_fqdn['value'] + ":9090</a><br>" +"\n")
print "</p></body>"
print "</html>"
