#!/bin/bash

(sudo /run.sh >> /pass_root &)
(/opt/jboss/jboss-eap-6.4/bin/add-user.sh jboss jb0ss@dmin &)
/opt/jboss/jboss-eap-6.4/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0