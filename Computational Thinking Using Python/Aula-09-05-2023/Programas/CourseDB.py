import oracledb
import pandas as pd


def main():

    conexao, instSQL, conn = ()
    opc = 0

    while (opc != 5 and conexao == True):
        print("1 - Cadastro de alunos")
        print("2 - Cadastro de cursos")
        print("3 - Relatorio de todos os alunos")
        print("4 - Relatorio de todos os cursos")
        print("5 - Sair")
        opc = int(input("Digite a opção (1-5): "))

        #Cadastro de alunos
        if (opc == 1):

            opcAluno = 0
            while (opcAluno != 4):
                print("1 - Inserção")
                print("2 - Alteração")
                print("3 - Exclusão")
                print("4 - Voltar")
                opcAluno = int(input("Digite a opção (1-4): "))

                if (opcAluno == 1):
                    try:
                        ra = int(input("Digite o RA: "))
                        nome = input("Digite o nome: ")
                        idade = int(input("Digite a idade: "))

                        #Exibe todos os cursos
                        strConsulta = 'SELECT * FROM cursos'
                        strColunas = f"""SELECT column_name FROM all_tab_cols WHERE table_name = 'CURSOS'"""

                        instSQL.execute(strColunas)
                        dados = instSQL.fetchall()
                        colunas = []
                        for i in range(len(dados)):
                            colunas.append(dados[i][0].split("_")[1])

                        consultaTabela(instSQL, strConsulta, colunas)

                        #Usuario vai escolher qual curso sera vinculado ao aluno
                        listaDados = []

                        idCurso = int(input("Digite o id do curso a ser vinculado ao aluno: "))

                        consulta = f"""SELECT * FROM cursos WHERE curso_id = {idCurso}"""

                        instSQL.execute(consulta)
                        dados = instSQL.fetchall()

                        for dado in dados:
                            listaDados.append(dado)

                        if (len(listaDados) == 0):
                            print("Id não encontrado")

                    except ValueError:
                        print("Digite valores numericos")
                    else:
                        strInsert = f"""INSERT INTO alunos (aluno_ra,aluno_nome,aluno_idade,aluno_cursoid) VALUES ({ra},'{nome}',{idade},{idCurso})"""
                        insertTabela(instSQL, conn, strInsert)

                elif (opcAluno == 2):

                    listaDados = []

                    id = int(input("Digite o id do aluno a ser alterado"))

                    consulta = f"""SELECT * FROM alunos WHERE aluno_id = {id}"""

                    instSQL.execute(consulta)
                    dados = instSQL.fetchall()

                    for dado in dados:
                        listaDados.append(dado)

                    if (len(listaDados) == 0):
                        print("Id não encontrado")
                    else:
                        try:
                            novoRA = int(input("Digite o novo RA: "))
                            novoNome = input("Digite o novo nome: ")
                            novaIdade = int(input("Digite a nova idade: "))
                            # Exibe todos os cursos
                            strConsulta = 'SELECT * FROM cursos'
                            strColunas = f"""SELECT column_name FROM all_tab_cols WHERE table_name = 'CURSOS'"""

                            instSQL.execute(strColunas)
                            dados = instSQL.fetchall()
                            colunas = []
                            for i in range(len(dados)):
                                colunas.append(dados[i][0].split("_")[1])

                            consultaTabela(instSQL, strConsulta, colunas)

                            #Usuario vai escolher qual curso sera vinculado ao aluno
                            listaDados = []

                            idCurso = int(input("Digite o id do curso a ser vinculado ao aluno: "))

                            consulta = f"""SELECT * FROM cursos WHERE curso_id = {idCurso}"""

                            instSQL.execute(consulta)
                            dados = instSQL.fetchall()

                            for dado in dados:
                                listaDados.append(dado)

                            if (len(listaDados) == 0):
                                print("Id não encontrado")
                        except ValueError:
                            print("Digite valores numericos")
                        else:
                            strUpdate = f"""UPDATE alunos SET aluno_ra={novoRA},aluno_nome='{novoNome}',aluno_idade={novaIdade},aluno_cursoid={idCurso} WHERE aluno_id={id}"""
                            updateTabela(instSQL, conn, strUpdate)

                elif (opcAluno == 3):

                    listaDados = []

                    id = int(input("Digite o Id do aluno a ser excluido: "))

                    consulta = f"""SELECT * FROM alunos WHERE aluno_id = {id}"""

                    instSQL.execute(consulta)
                    dados = instSQL.fetchall()

                    for dado in dados:
                        listaDados.append(dado)

                    if (len(listaDados) == 0):
                        print("O id digitado nao existe na tabela")
                    else:
                        strDelete = f"""DELETE FROM alunos WHERE aluno_id={id}"""
                        deleteTabela(instSQL, conn, strDelete)

        #Cadastro de Cursos
        elif (opc == 2):

            opcCurso = 0
            while (opcCurso != 4):
                print("1-Inserção")
                print("2-Alteração")
                print("3-Exclusão")
                print("4-Voltar")
                opcCurso = int(input("Digite a opção (1-4): "))

                if (opcCurso == 1):
                    try:
                        nome = input('Digite o nome do curso: ')
                        cargaHoraria = int(input("Digite a carga horária do curso: "))
                        area = input("Digite a área: ")
                    except ValueError:
                        print("Digite valores numéricos")
                    else:
                        strInsert = f"""INSERT INTO cursos (curso_nome,curso_cargahoraria,curso_area) VALUES ('{nome}',{cargaHoraria},'{area}')"""
                        insertTabela(instSQL, conn, strInsert)

                elif (opcCurso == 2):

                    listaDados = []

                    idCurso = int(input("Digite o id do curso a ser alterado: "))

                    consulta = f"""SELECT * FROM cursos WHERE curso_id = {idCurso}"""

                    instSQL.execute(consulta)
                    dados = instSQL.fetchall()

                    for dado in dados:
                        listaDados.append(dado)

                    if (len(listaDados) == 0):
                        print("Id não encontrado")
                    else:
                        try:
                            novoNome = input("Digite o novo nome: ")
                            novaCargaHoraria = int(input("Digite a nova carga horária: "))
                            novaArea = input("Digite a nova area: ")
                        except ValueError:
                            print("Digite valores numericos")
                        else:
                            strUpdate = f"""UPDATE cursos SET curso_nome='{novoNome}',curso_cargahoraria={novaCargaHoraria},curso_area='{novaArea}' WHERE curso_id={idCurso}"""
                            updateTabela(instSQL, conn, strUpdate)

                elif (opcCurso == 3):

                    listaDados = []

                    idCurso = int(input("Digite o Id do curso a ser excluido: "))

                    consulta = f"""SELECT * FROM cursos WHERE curso_id = {idCurso}"""

                    instSQL.execute(consulta)
                    dados = instSQL.fetchall()

                    for dado in dados:
                        listaDados.append(dado)

                    if (len(listaDados) == 0):
                        print("O id digitado nao existe na tabela")
                    else:
                        strDelete = f"""DELETE FROM cursos WHERE curso_id={idCurso}"""
                        deleteTabela(instSQL, conn, strDelete)

        #Relatório de todos os alunos
        elif (opc == 3):

            strConsulta = 'SELECT * FROM alunos'
            strColunas = f"""SELECT column_name FROM all_tab_cols WHERE table_name = 'ALUNOS'"""

            instSQL.execute(strColunas)
            dados = instSQL.fetchall()

            colunas = []
            for i in range(len(dados)):
                colunas.append(dados[i][0].split("_")[1])

            consultaTabela(instSQL, strConsulta, colunas)

        elif (opc == 4):

            strConsulta = 'SELECT * FROM cursos'
            strColunas = f"""SELECT column_name FROM all_tab_cols WHERE table_name = 'CURSOS'"""

            instSQL.execute(strColunas)
            dados = instSQL.fetchall()
            colunas = []
            for i in range(len(dados)):
                colunas.append(dados[i][0].split("_")[1])

            consultaTabela(instSQL, strConsulta, colunas)


def conectaBD():

    try:
        #Conectar com o Servidor
        dnStr = oracledb.makedsn("oracle.fiap.com.br", "1521", "ORCL")
        #Efetuar a conexao com o usuario
        conn = oracledb.connect(user='RM97136', password='270204', dsn=dnStr)
        #Criar as instrucoes para cada modulo
        instSQL = conn.cursor()
    except Exception as e:
        print("Erro: ", e)
        conexao = False
        instSQL = ""
        conn = ""
    else:
        conexao = True

    return (conexao, instSQL, conn)

def insertTabela(instSQL, conn, strInsert):

    try:
        instSQL.execute(strInsert)
        conn.commit()
    except:
        print("Erro de transacao com o BD")
    else:
        print("Dados gravados com sucesso")

def consultaTabela(instSQL, strConsulta, colunas):

    lista = []

    #Executa a consulta (Select) no BD
    instSQL.execute(strConsulta)

    #Captura todos os registros vindos pela consulta
    dados = instSQL.fetchall()

    #Insere os registros em uma lista
    for registro in dados:
        lista.append(registro)

    #Ordena a lista
    lista = sorted(lista)

    #Gera um Dataframe com os dados da lista (Pandas)
    baseDf = pd.DataFrame.from_records(lista, columns=colunas, index=colunas[0])

    if (baseDf.empty):
        print("Nao ha registros cadastrados")
    else:
        print(baseDf)
        print("\n")

def updateTabela(instSQL, conn, strUpdate):

    try:
        instSQL.execute(strUpdate)
        conn.commit()
    except:
        print("Erro de transacao com o BD")
    else:
        print("Dados alterados com sucesso")

def deleteTabela(instSQL, conn, strDelete):

    try:
        instSQL.execute(strDelete)
        conn.commit()
    except:
        print("Erro de transacao com o BD")
    else:
        print("Dados excluidos com sucesso")

if (__name__ == "__main__"):
    main()