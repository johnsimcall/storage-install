from ravello_sdk import *
import json, sys

with open('config.json') as file:
    config = json.load(file)

client = RavelloClient()
client.login(username=config['username'], password=config['password'])

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
                sys.stdout.write(vm_fqdn['value'] +"\n")
