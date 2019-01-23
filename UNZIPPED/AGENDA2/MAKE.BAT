@ECHO OFF
ECHO  ÿ
ECHO  AGENDA v1.1 Compile
ECHO  Criado e Desenvolvido por Hugo Ferreira, 1993.
ECHO  -----------------------------------------------------------------------
ECHO  Programa para compilar as Sources de AGENDA.EXE
ECHO  Neste directorio precisam de estar os seguintes ficheiros:
ECHO    AGENDA  .BAS (Sources de AGENDA v1.1)
ECHO    AGENDA  .LNK (Ficheiro com as ordens para Linkar o ficheiro)
ECHO    BC      .EXE (Basic Compiler v4.50 ou +)
ECHO    LINK    .EXE (Microsoft Linker)
ECHO    BCOM45  .LIB (Basic Comand Library 4.50)
ECHO    QB      .LIB (Quick Basic 4.50 Library)
ECHO  ÿ
ECHO  Prima uma tecla para continuar ou CTRL+C para sair.
PAUSE>NUL
ECHO  ÿ
ECHO  A COMPILAR... Aguarde um momento.  ÿ
ECHO  ÿ
BC AGENDA.BAS /E/X/O/T/C:512;
LINK @AGENDA.LNK
ECHO ÿAGENDA.BAS foi compilado para AGENDA.EXE.
ECHO  ÿ
