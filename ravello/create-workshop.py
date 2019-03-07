# Original work by Tony James

from ravello_sdk import *
import time, json

with open('config.json') as file:
    config = json.load(file)

client = RavelloClient()
client.login(username=config['username'], password=config['password'])

with open('users.json') as file:
    users = json.load(file)
    for user in users:
        # FEDSLED-SA-RHHI-Workshop-Q1-FY20
        # https://cloud.ravellosystems.com/#/0/library/blueprints/3125677031714/canvas
        app_dict = {
            'name': 'FEDSLED-SA-RHHI-' + user,
            'baseBlueprintId': '3125677031714'
        }
        print "Creating application " + app_dict['name'] + "..."
        client.create_application(app=app_dict)
        app = client.get_application_by_name(app_name=app_dict['name'])
        app_dict = {
            'optimizationLevel': 'PERFORMANCE_OPTIMIZED',
            'preferredRegion': 'us-east-5',
            'startAllVms': 'False'
        }
        print "Publishing application..."
        client.publish_application(app=app['id'], req=app_dict)
        client.start_application(app=app)
