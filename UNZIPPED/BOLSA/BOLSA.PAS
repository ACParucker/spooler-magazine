{$M 64000,0,200000 }
(****************************************************************************)
(*                                                                          *)
(*                                BOLSA                                     *)
(*                                                                          *)
(*                           Por : Nuno Funico                              *)
(*                                                                          *)
(*                           SPOOLER MAGAZINE                               *)
(*                                                                          *)
(*                                                                          *)
(*                           Correspondˆncia:                               *)
(*                                                                          *)
(*                           Nuno Funico                                    *)
(*                           Bairro Sra. da Gra‡a n§21                      *)
(*                           6300 GUARDA                                    *)
(*                                                                          *)
(*                                                                          *)
(*                                                                          *)
(****************************************************************************)


Program Bolsa;

Uses Crt,Efeitos,Jogo;


Begin  { Corpo do programa }

  checkbreak:= false;
  Textmode(CO80);

  { Mostra o logo da BOLSA}
  Logo;

  { Lˆ o n£mero de jogadas e de jogadores }
  Jogadores_Jogadas;

  { Joga }
  Jogar;

End. { fim do programa }

