pipeline {
    agent any

    triggers {
        pollSCM('* * * * *')
    }

    stages {
        stage('0. Baixar Binarios do Docker e Compose') {
            steps {
                echo 'Baixando os executáveis de forma isolada...'
                sh """
                    if ! command -v docker &> /dev/null; then
                        curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-26.1.3.tgz -o docker.tgz
                        tar -xzvf docker.tgz
                        mv docker/docker /usr/local/bin/
                        rm -rf docker docker.tgz
                    fi

                    mkdir -p /usr/local/lib/docker/cli-plugins
                    if [ ! -f /usr/local/lib/docker/cli-plugins/docker-compose ]; then
                        curl -fsSL https://github.com/docker/compose/releases/download/v2.27.1/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
                        chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
                        ln -s /usr/local/lib/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose || true
                    fi
                """
            }
        }

        stage('1. Clonar Repositorio') {
            steps {
                echo 'Baixando a versão correta do Git...'
                // 👇 ISSO AQUI garante que o Jenkins baixe os arquivos (incluindo o index.html correto) do commit atual ou do rollback
                checkout scm
            }
        }

        stage('2. Build da Imagem e Deploy') {
            steps {
                echo 'Gerando nova imagem Docker na porta 8081...'
                sh """
                    # Adicionamos o --force-recreate para garantir que o container antigo caia e suba o novo com o index corrigido
                    docker compose up -d --build --force-recreate
                """
            }
        }

        stage('3. Limpeza de Imagens Antigas') {
            steps {
                echo 'Limpando imagens antigas...'
                sh """
                    docker image prune -f
                """
            }
        }
    }
}
