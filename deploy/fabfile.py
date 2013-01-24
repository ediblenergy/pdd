from fabric.api import run, cd
def deploy():
    project_dir = '/opt/pdd'
    repo = 'pdd'
    branch = 'master'
    with cd(project_dir):
        with cd('%s/%s' % ( project_dir, repo ) ):
            run('git clean -xfd && git fetch && git checkout %s && git pull origin %s' % ( branch, branch ))
            run('PATH=/usr/local/apps-perl/5.16.0/bin:$PATH cpanm -L %s/perl5 --installdeps . -v' % ( project_dir ) )
            run('perl Makefile.PL && make test')
