@ECHO OFF
ECHO ÚÄÄÄÄ-Ä--ù    ú                                         ú          ú -Ä-ÄÄÄ¿
ECHO ù                   ú   ú -ú-Ä-PARADiSE CiTYÄ--ú- ú   ú                    ù
ECHO ú          .ÜÜ ú  ÜÜÜÜÜ  ÜÜÜú  ÜÜÜ   úÜÜÜ þ   ÜÜÜ . ÜÜÝ   úÜÜÜÜ   i        ú
ECHO            ÞÛ ß.  ùÛÛ   ÞÛ ßÛ  ßÜ Ûú ÞÜÜú ÛÛ  ßÜ.ßú ÛÛù   ÛÛþ ÛÛ  N
ECHO ú          ÜßßßÛÜ  ÞÛ.þ ÜÛßßÛ  ÞßßÜ  ÛÛþ  ÞÛú ÞßßþÜ ÛÛþ   ÞÛú ÞÛÝ T        ú
ECHO            ÞÛÜþÞÛ  ÞÛÝú ÞÛ þÞÝ ÞÛùÛÝ ÛÛÝ. ÞÛÝ ÞÛÜÜÝ ÞÛÝÞÝ ÛÛ. ÛÛ  R
ECHO ú           ßßßß   ßßß   ß  ß  .ß  ß ßßß  ßßß  ßßß  .ßßß  ßßßßßù  O        ú
ECHO ù                   Coded By SyNeRGiE (C) Copyright 1994                   ù
ECHO ÀÄÄÄúÄ--ú-ú ú                                        ú         ú     úÄ-ÄÄÄÙ
ECHO ÚÄÄÄÄ-Ä--ù    ú                                         ú          ú -Ä-ÄÄÄ¿
ECHO ú PARA QUALQUER DUVIDA CONTACTAR:          PARADiSE CiTY BBS  (01) 4602328 ú
ECHO ù Hugo Ferreira, 2:362/46 (FidoNet)        Paraceta do Barro, Alcoit„o     ù
ECHO ú      SyNeRGiE, 96:6902/0 (KotoNet)       2765 ESTORIL                    ú
ECHO ÀÄÄÄúÄ--ú-ú ú                                        ú         ú     úÄ-ÄÄÄÙ
ECHO ÿ                                                                          ÿ
ECHO Este batch vai compilar a intro PARADiSE CiTY Starfield.                   ÿ
ECHO Deve ter na directoria currente todos os sources pertencentes … intro,     ÿ
ECHO e ainda o TASM (v2.01+) e o TLINK (v3.01+).                                ÿ
ECHO ÿ                                                                          ÿ
PAUSE
IF NOT EXIST TASM.EXE GOTO TASMBAD
IF NOT EXIST TLINK.EXE GOTO TLINKBAD
IF NOT EXIST PARADISE.ASM GOTO PCBAD
IF NOT EXIST PARADISE.INC GOTO PCINCBAD
IF NOT EXIST AUXILIAR.INC GOTO AUXINCBAD
IF NOT EXIST ANSI.INC GOTO ANSINCBAD
IF NOT EXIST CITY.INC GOTO CTINCBAD
IF NOT EXIST PALETTE.INC GOTO PALINCBAD
IF NOT EXIST FONT.INC GOTO FNTINCBAD
IF NOT EXIST STARPOS.INC GOTO STRINCBAD
IF NOT EXIST TEXT.INC GOTO TXTINCBAD

TASM PARADISE;
TLINK PARADISE;

ECHO PARADiSE CiTY Starfield Intro v1.0 compilada com exito.
GOTO FINISH

:TASMBAD
ECHO ERRO: TASM.EXE n„o foi encontrado.
GOTO END

:TLINKBAD
ECHO ERRO: TLINK.EXE n„o foi encontrado.
GOTO END

:PCBAD
ECHO ERRO: PARADISE.ASM n„o foi encontrado.
GOTO END

:PCINCBAD
ECHO ERRO: PARADISE.INC n„o foi encontrado.
GOTO END

:AUXINCBAD
ECHO ERRO: AUXILIAR.INC n„o foi encontrado.
GOTO END

:ANSINCBAD
ECHO ERRO: ANSI.INC n„o foi encontrado.
GOTO END

:CTINCBAD
ECHO ERRO: CITY.INC n„o foi encontrado.
GOTO END

:PALINCBAD
ECHO ERRO: PALETTE.INC n„o foi encontrado.
GOTO END

:FNTINCBAD
ECHO ERRO: FONT.INC n„o foi encontrado.
GOTO END

:STRINCBAD
ECHO ERRO: STARPOS.INC n„o foi encontrado.
GOTO END

:TXTINCBAD
ECHO ERRO: TEXT.INC n„o foi encontrado.
GOTO END

:END
ECHO PARADiSE CiTY Starfield Intro v1.0 NŽO COMPILADA.

:FINISH
ECHO ÿ
