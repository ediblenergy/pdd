from fabric.api import run, cd, env

env.hosts=["localhost"]
env.user="supervisord"

project_dir = '/opt/pdd'
repo = 'pdd'
branch = 'master'
env_prefixes=[
    'PATH=/usr/local/apps-perl/5.16.0/bin:$PATH',
    'DBIC_TRACE=1',
    'PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/opt/pdd/perl5"',
    'PERL_MB_OPT="--install_base /opt/pdd/perl5"',
    'PERL_MM_OPT="INSTALL_BASE=/opt/pdd/perl5"',
    'PERL5LIB="%s/%s/lib:/opt/pdd/perl5/lib/perl5/x86_64-linux:/opt/pdd/perl5/lib/perl5"' % ( project_dir, repo ),
    'PATH="/opt/pdd/perl5/bin:$PATH"',
    'HARNESS_OPTIONS=j4:c',
]
env_string = " ".join(env_prefixes)

def installdeps():
    with cd(project_dir):
        with cd('%s/%s' % ( project_dir, repo ) ):
            run('%s cpanm -L %s/perl5 --installdeps .' % (env_string, project_dir ) )

def checkout():
    with cd(project_dir):
        with cd('%s/%s' % ( project_dir, repo ) ):
            run('git clean -fd && git fetch && git checkout %s && git pull origin %s' % ( branch, branch ))
    
def deploy():
    with cd(project_dir):
        with cd('%s/%s' % ( project_dir, repo ) ):
            checkout()
            installdeps()
            run('%s perl -Ilib Makefile.PL' % env_string)
            run( '%s make test' % env_string )

def perl(cmd,pdd_env='dev'):
    with cd( '%s/%s' % ( project_dir, repo ) ):
        run( "PDD_ENVIRONMENT=%s %s perl -Ilib %s" % (pdd_env,env_string, cmd) )

def cpanm(args):
        with cd('%s/%s' % ( project_dir, repo ) ):
            run('%s cpanm -L %s/perl5 -v %s' % (env_string, project_dir, args ) )

def test():
    with cd(project_dir):
        with cd('%s/%s' % ( project_dir, repo ) ):
            run( '%s prove -lv' % env_string )
