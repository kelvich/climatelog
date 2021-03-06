# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{stas@justscale.me:4242}
role :web, %w{stas@justscale.me:4242}
role :db,  %w{stas@justscale.me:4242}


server 'justscale.me'


