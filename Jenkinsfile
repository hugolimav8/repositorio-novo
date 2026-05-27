pipeline {
    agent any

    stages {
        stage('0. Baixar Binario do Docker') {
            steps {
                echo 'Baixando o executável do Docker de forma isolada...'
                sh """
                    if ! command -v docker &> /dev/null; then
                        curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-26.1.3.tgz -o docker.tgz
                        tar -xzvf docker.tgz
                        mv docker/docker /usr/local/bin/
                        mv docker/docker-compose /usr/local/bin/ || true
                        rm -rf docker docker.tgz
                    fi
                """
            }
        }

        stage('1. Clonar Repositorio') {
            steps {
                echo 'Baixando a versão mais recente do Git...'
            }
        }

        stage('2. Build da Imagem e Deploy') {
            steps {
                echo 'Gerando nova imagem Docker na porta 8081...'
                sh """
                    docker compose up -d --build
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
