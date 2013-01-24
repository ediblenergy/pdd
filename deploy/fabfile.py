from fabric.api import run, cd
def deploy():
    project_dir = '/opt/pdd'
    repo = 'pdd'
    branch = 'master'

    env_prefixes=[
        'PATH=/usr/local/apps-perl/5.16.0/bin:$PATH',
        'PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/opt/pdd/perl5"',
        'PERL_MB_OPT="--install_base /opt/pdd/perl5"',
        'PERL_MM_OPT="INSTALL_BASE=/opt/pdd/perl5"',
        'PERL5LIB="/opt/pdd/perl5/lib/perl5/x86_64-linux:/opt/pdd/perl5/lib/perl5"',
        'PATH="/opt/pdd/perl5/bin:$PATH"',
    ]
    env_string = " ".join(env_prefixes)
    with cd(project_dir):
        with cd('%s/%s' % ( project_dir, repo ) ):
            run('git clean -xfd && git fetch && git checkout %s && git pull origin %s' % ( branch, branch ))
            run('%s cpanm -L %s/perl5 --installdeps . -v' % (env_string, project_dir ) )
            run('%s perl Makefile.PL' % env_string)
            run( '%s make test' % env_string )
