pipeline {
    agent any

    // 👇 AGORA ELE CHECA A CADA MINUTO, MAS SÓ BUILDA SE TIVER COMMIT NOVO
    triggers {
	pollSCM('0 22 * * *')
    }

    stages {
        stage('0. Baixar Binarios do Docker e Compose') {
            steps {
                echo 'Baixando os executáveis de forma isolada...'
                sh """
                    # 1. Baixa e instala o cliente Docker tradicional
                    if ! command -v docker &> /dev/null; then
                        curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-26.1.3.tgz -o docker.tgz
                        tar -xzvf docker.tgz
                        mv docker/docker /usr/local/bin/
                        rm -rf docker docker.tgz
                    fi

                    # 2. Baixa e instala o plugin do Docker Compose v2
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
                echo 'Limpages imagens antigas...'
                sh """
                    docker image prune -f
                """
            }
        }
    }
}
