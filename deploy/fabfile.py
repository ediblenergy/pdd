from fabric.api import run, cd

env.hosts=["localhost"]
env.user="supervisord"

project_dir = '/opt/pdd'
repo = 'pdd'
branch = 'master'
env_prefixes=[
    'PATH=/usr/local/apps-perl/5.16.0/bin:$PATH',
    'PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/opt/pdd/perl5"',
    'PERL_MB_OPT="--install_base /opt/pdd/perl5"',
    'PERL_MM_OPT="INSTALL_BASE=/opt/pdd/perl5"',
    'PERL5LIB="%s/%s/lib:/opt/pdd/perl5/lib/perl5/x86_64-linux:/opt/pdd/perl5/lib/perl5"' % ( project_dir, repo ),
    'PATH="/opt/pdd/perl5/bin:$PATH"',
    'HARNESS_OPTIONS=j4:c',
]
env_string = " ".join(env_prefixes)

def deploy():

    with cd(project_dir):
        with cd('%s/%s' % ( project_dir, repo ) ):
            run('git clean -fd && git fetch && git checkout %s && git pull origin %s' % ( branch, branch ))
            run('%s cpanm -L %s/perl5 --installdeps . -v' % (env_string, project_dir ) )
            run('%s perl -Ilib Makefile.PL' % env_string)
            run( '%s make test' % env_string )

def test_module(module):
    with cd( '%s/%s' % ( project_dir, repo ) ):
        run( "%s perl -Ilib -M%s -e 1" % ( env_string, module) )

def cpanm(args):
        with cd('%s/%s' % ( project_dir, repo ) ):
            run('%s cpanm -L %s/perl5 -v %s' % (env_string, project_dir, args ) )

def test():
    with cd(project_dir):
        with cd('%s/%s' % ( project_dir, repo ) ):
            run( '%s prove -lv' % env_string )
