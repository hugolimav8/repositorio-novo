pipeline {
    agent any

    stages {
        stage('1. Clonar Repositório') {
            steps {
                echo 'Baixando a versão mais recente do Git...'
            }
        }

        stage('2. Build da Imagem e Deploy') {
            steps {
                echo 'Gerando nova imagem Docker e reiniciando o container na porta 8081...'
                # O --build garante que a imagem antiga seja descartada e uma nova seja criada
                sh 'docker compose up -d --build'
            }
        }

        stage('3. Limpeza de Imagens Antigas') {
            steps {
                echo 'Limpando imagens antigas que ficaram sem tag (dangling)...'
                # Evita que o disco da sua máquina Oracle lote com restos de builds antigos
                sh 'docker image prune -f'
            }
        }
    }
}
