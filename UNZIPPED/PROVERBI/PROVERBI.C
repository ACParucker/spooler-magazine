#include<time.h>
#include<conio.h>
#include<stdio.h>
#include<stdlib.h>

#define PROVERBIOS         127



char *p[] = {

"A cavalo dado n„o se olha a dente (ou a idade).",
"N„o se deve desdenhar o que se recebe graciosamente.",

"A fome ‚ o melhor tempero.",
"Quando se tem fome, a pior comida parece a mais saborosa.",

"A'gua d ,  gua leva.",
"Perde-se com facilidade aquilo que com facilidade se consegue.",

"A justi‡a come‡a em casa.",
"Para termos autoridade de julgar os estranhos, cumpre julgar primeiro os nossos parentes ou os amigos mais chegados.",

"Amarra-se o cavalo … vontade do dono.",
"N„o se contraria a opini„o duma pessoa, quando o interesse ‚ exclusivamente dela.",

"Amor com amor se paga.",
"Dispensa-se a uma pessoa o mesmo tratamento que dela se recebe.",

"Amor e f‚ nas obras se vˆ.",
"Pelo que as pessoas fazem ‚ que se vˆ o que elas realmente s„o.",

"A noite ‚ boa conselheira.",
"Conv‚m deixar para o dia seguinte uma decis„o importante, pois a noite propicia maduras reflex”es.",

"Antes prevenir do que remediar.",
" melhor atenuar o mal do que atenuar-lhe as consequˆncias.",

"Antes que cases, vˆ o que fazes.",
"Antes de tomares uma decis„o, pensa nas consequˆncias.",

"Antes s¢ que mal acompanhado.",
" prefer¡vel n„o ter companhia, a tˆ-la inconvenientemente ou comprometedora.",

"Antes tarde do que nunca.",
" melhor fazer uma coisa conveniente depois do tempo prop¡cio, do que deixar de fazˆ-la.",

"A ocasi„o faz o ladr„o.",
"As circunstƒncias ou facilidades podem levar-nos a praticar actos repreens¡veis, do que jamais nos julgar¡amos capazes.",

"A ociosidade ‚ a m„e de todos os v¡cios.",
"A falta de ocupa‡„o d  ensejo a que se acumulem v¡cios.",

"Ap¢s a tempestade vem a bonan‡a.",
"A momentos de afli‡„o sucedem momentos de tranquilidade.",

"As paredes tˆm ouvidos.",
"Conv‚m tratar com a m xima descri‡„o os assuntos sigilosos, desconfiando de tudo e de todos.",

"Assim como vive o Rei, vivem os vassalos.",
"As pessoas humildes tendem a imitar os actos das que se acham em posi‡”es elevadas.",

"Bem mal ceia quem come de m„o alheia.",
"A pessoa que n„o trabalha para o pr¢prio sustento, n„o pode contar com a ajuda de outros.",

"Brigas de namorados, amores dobrados.",
"Os arrufos entre os que se querem contribuem para consolidar a afei‡„o.",

"Brigam as comadres, aparecem as verdades.",
"Quando entram em choque os interesses de s¢cios ou amigos, denunciam uns as mazelas dos outros.",

"Cada macaco em seu galho.",
"Ningu‚m deve ir al‚m das suas atribui‡”es.",

"Cada qual com o seu igual.",
" inconveniente procurar algu‚m para conv¡vio de condi‡„o diferente da sua.",

"Cada qual no seu of¡cio.",
"Um indiv¡duo n„o deve opinar sobre mat‚ria estranha … sua actividade.",

"Cada qual sabe onde lhe aperta o sapato.",
"S¢ a pr¢pria pessoa sabe as necessidades que tem ou as dificuldades que enfrenta.",

"Cada um d  o que tem.",
"N„o se pode esperar de algu‚m aquilo que est  acima das suas possibilidades, m‚ritos ou virtudes.",

"Cada um por si e Deus por todos.",
"Cada qual deve tratar do que lhe compete e, esperar que Deus providencie o que compete a todos.",

"C„o que ladra n„o morde.",
"Quem faz muitas amea‡as n„o costuma cumprir nenhuma.",

"Casa onde n„o h  p„o, todos gritam e ningu‚m tem raz„o.",
"A fome leva ao desespero, … irreflex„o e ao desentendimento.",

"Cavalo velho n„o pega andadura.",
"A pessoa que tem um h bito inveterado, n„o o deixa com facilidade.",

"Cesteiro que faz um cesto faz um cento.",
"Quem prevarica uma vez, ‚ capaz de prevaricar todas as vezes que tiver a mesma oportunidade.",

"Comer e co‡ar est  no come‡ar.",
"Certas coisas que n„o se tˆm vontade de fazer, basta come‡ -las para lev -las avante satisfatoriamente.",

"Da discuss„o nasce a luz.",
"Do di logo esclarecido surge muitas vezes a verdade.",

"Dai a C‚sar o que ‚ de C‚sar e a Deus o que ‚ de Deus.",
"Deve dar-se a cada um o que lhe ‚ devido.",

"Boa  rvore, bons frutos.",
"Das pessoas que tˆm bons antecedentes s¢ se esperam boas ac‡”es.",

"Das boas inten‡”es o inferno est  cheio.",
"N„o basta projectar, ter o prop¢sito de fazer alguma coisa; o importante ‚ fazˆ-la.",

"De gr„o a gr„o a galinha enche o papo.",
"Pouco a pouco, e perseverantemente, consegue-se o que se pretende.",

"De noite todos os gatos s„o pardos.",
"Em situa‡”es confusas, n„o se distinguem bem as pessoas e coisas, defeitos e qualidades, o amigo do inimigo.",

"De pequenino ‚ que se torce o pepino.",
"A educa‡„o do indiv¡duo deve come‡ar na mais tenra infƒncia.",

"Deus escreve certo por linhas tortas.",
"Coisas que aparentemente nos s„o adversas acabam por nos ser favor veis.",

"Devagar se vai ao longe.",
"Com paciˆncia e perseveran‡a conseguem-se os melhores ˆxitos.",

"Diz-me com quem andas e te direi quem ‚s.",
"As pessoas podem ser julgadas pelas companhias que escolhem.",

"Dois olhos vˆem mais do que um s¢.",
" conveniente recorrer a bons conselheiros, quando se tem de resolver quest”es dif¡ceis.",

"Do prato … boca perde-se a sopa.",
"Entre um projecto e a sua realiza‡„o, podem surgir muitos obst culos imprevistos que furtam a concretiza‡„o dos prop¢sitos.",

"Dos males o menor.",
"Entre duas situa‡”es m s, ‚ natural que se escolhe ou se aceite a menos grave.",

"Duro com duro n„o faz bom muro.",
"Dificilmente se harmonizam pessoas que defendem, com o mesmo ardor, interesses que se contrariam.",

"Entre briga de marido e mulher n„o metas a colher.",
"Ningu‚m deve imiscuir-se em disputas entre parentes ou amigos muito chegados.",

"Em terra de cegos quem tem um olho ‚ rei.",
"Pessoa pouco instru¡da ou de poucos m‚ritos ‚ capaz de passar por s bia ou competente entre ignorantes e n‚scios.",

"Faz o que te digo e n„o o que fa‡o.",
"Alus„o ir¢nica aos que d„o bons conselhos, mas agem ou comportam-se de maneira diferente daquela que recomendam.",

"Ferro que n„o se usa, gasta-o a ferrugem.",
"O que n„o se mant‚m em actividade acaba por inutilizar-se.",

"Festa acabada, m£sicos a p‚.",
"As pessoas s„o bem tratadas enquanto s„o necess rios os seus servi‡os, e esquecidas depois de prest -los.",

"Filho de peixe sabe nadar.",
"Os filhos herdam as tendˆncias, os caracteres dos pais.",

"Filhos criados, trabalhos dobrados.",
"Os filhos j  crescidos causam-nos maiores preocupa‡”es do que as do tempo em que eram ainda crian‡as.",

"Gato escaldado at‚ de  gua fria tem medo.",
"Aprendemos a recear tudo o que nos lembre uma experiˆncia penosa, algo que alguma vez nos causou dano.",

"Grandes caminhadas, grandes mentiras.",
"Admite-se que as pessoas que viajam muito, exageram a mat‚ria de suas narrativas.",

"Grandes peixes, pescam-se em grandes rios.",
"Bons resultados obtˆm-se em neg¢cios de vulto.",

"H  males que vˆm para bem.",
"O que nos parece …s vezes um desastre pode trazer-nos, no fim, algum proveito.",

"Ladr„o que rouba a ladr„o tem cem anos de perd„o.",
"Os que prejudicam a quem muito prejudicou podem ser julgados com maior tolerƒncia.",

"Lobo n„o come lobo.",
"Os maus n„o se empenham em prejudicar uns aos outros; respeitam-se porque se temem.",

"Longe dos olhos, longe do cora‡„o.",
" comum esquecer uma pessoa querida, quando dela nos afastamos por muito tempo. A separa‡„o arrefece as afei‡”es.",

"Louvor em boca pr¢pria ‚ vitup‚rio.",
"Perde no conceito que dele se faz, aquele que proclama os pr¢prios m‚ritos.",

"Macaco velho n„o mete a m„o em cumbuca.",
"Pessoa que tem experiˆncia na vida n„o se deixa iludir com facilidade e, age com mais cautela.",

"Mais vale quem Deus ajuda do que quem cedo madruga.",
"A ajuda de Deus tem mais valia do que a diligˆncia ou o trabalho do homem.",

"Mais vale um gosto do que seis vint‚ns.",
"'A pessoa que realiza um desejo, que satisfaz um prazer, n„o importa o que isso lhe custe.",

"Mais vale um p ssaro na m„o do que dois a voar.",
" melhor ter o pouco certo do que o muito duvidoso.",

"Mais vale um ®toma¯ do que dois ®te darei¯.",
" prefer¡vel pouco dado no momento do que muito prometido para depois.",

"Mal de muitos consolo ‚.",
"Quando se sabe que outros tamb‚m sofrem, aceita-se com mais resigna‡„o o pr¢prio sofrimento.",

"Muito riso, pouco siso.",
"Quem ri de tudo e todos, sem distinguir oportunidades, revela n„o ser bastante sensato ou ajuizado.",

"Na adversidade ‚ que se prova a amizade.",
"Os verdadeiros amigos conhecem-se nas horas amargas.",

"N„o h  fuma‡a sem fogo.",
"Os factos denunciam-se pelos ind¡cios.",

"N„o se deve despir um santo para vestir outro.",
"N„o ‚ razo vel privar algu‚m do que possui para suprir a necessidade de outrem.",

"Nem tudo que reluz ‚ ouro.",
"N„o se deve julgar valiosa uma coisa apenas pela sua boa aparˆncia.",

"Ningu‚m ‚ profeta na sua terra.",
"N„o ‚ comum reconhecer-se o justo valor de algu‚m na sua terra natal ou no lugar onde vive.",

"Novos tempos, novos costumes.",
"Os costumes mudam de acordo com o tempo.",

"Nunca se diga: desta  gua n„o beberei.",
"As circunstƒncias obrigam-nos, …s vezes, a admitir situa‡”es que consider vamos inadmiss¡veis, a fazer o que antes conden ramos ou rejeit ramos.",

"O barato sai caro.",
"O que custa pouco ‚ geralmente de fraca qualidade, consome-se logo e obriga-nos a novas despesas.",

"O h bito ‚ uma segunda Natureza.",
"Quem cultiva um h bito acaba por agir t„o instintivamente como se fosse um dom da Natureza.",

"O h bito n„o faz o monge.",
"O h bito nem sempre corresponde … natureza ¡ntima das pessoas.",

"O homem p”e e Deus disp”e.",
"Os nossos planos est„o sujeitos a imprevistos alheios … nossa vontade.",

"O olho do dono ‚ que engorda o cavalo.",
"Sem a assistˆncia do dono ou interessado, nada se faz satisfatoriamente.",

"O pote tanto vai … bica que um dia fica.",
"Quando se persiste numa empresa arriscada ‚ de esperar uma consequˆncia desagrad vel.",

"O Sol nasce para todos.",
"Todos tˆm o mesmo direito de participar dos recursos da Natureza, todos devem ter iguais oportunidades.",

"Os rios correm para o mar.",
"As riquezas e os bens tendem a encaminhar-se para aqueles que j  os tˆm em abundƒncia.",

"O temor do Senhor ‚ o princ¡pio da sabedoria.",
"Prov‚rbio de Salom„o, segundo o qual nenhuma sabedoria permanece sem f‚.",

"Palavras, leva-as o vento.",
"O que ‚ apenas dito n„o pode ser provado; s¢ se deve ter por v lido o que se documenta por escrito.",

"Palavras loucas, ouvidos moucos.",
"N„o se deve dar ouvidos a palavras insensatas.",

"Pau que nasce torto, tarde ou nunca se indireita.",
"V¡cios ou falhas de educa‡„o adquiridos na infƒncia, jamais ou dificilmente se corrigem.",

"Para grandes males, grandes rem‚dios.",
"Quest”es graves requerem providˆncias energ‚ticas.",

"Para quem sabe ler um pingo ‚ letra.",
"As pessoas, cultas e sagazes, percebem com facilidade as maiores subtilezas.",

"Pelos frutos conhece-se a  rvore.",
"Pelos actos pode julgar-se o seu autor.",

"Pior cego ‚ o que n„o quer ver.",
" in£til tentar convencer, os que se obstinam em descrer.",

"Pobreza n„o ‚ vileza.",
"As pessoas n„o devem ser desprezadas apenas por serem pobres e humildes; a pobreza n„o envergonha ningu‚m.",

"P“r o carro … frente dos bois.",
"Deve fazer-se tudo com ordem e l¢gica, dando-se precedˆncia ou prioridade …quilo ou aqu‚m a mere‡a.",

"Quando Deus quer,  gua fria ‚ rem‚dio.",
"A providˆncia divina opera maravilhas.",

"Quem ama o feio, bonito lhe parece.",
"Quem ama n„o vˆ, n„o reconhece os defeitos da pessoa ou coisa amada.",

"Quem cala consente.",
"Quem n„o se manifesta contra determinado facto, participa da sua responsabilidade, concorda com o que se faz ou diz.",

"Quem canta seus males espanta.",
"O cantos faz esquecer as m goas.",

"Quem come a carne que roa os ossos.",
"Quem se beneficiou em certos momentos ou situa‡”es, deve suportar tamb‚m os inconvenientes que deles possam resultar.",

"Quem com ferro fere, com ferro ser  ferido.",
"Quem usa violˆncia acaba por ser v¡tima de violˆncia.",

"Quem com porcos se mistura farelos come.",
"Quem escolhe m s companhias participa da sua fama.",

"Quem d  aos pobres empresta a Deus.",
"Quem faz o bem ao pr¢ximo recebe a recompensa divina.",

"Quem gasta mais do que tem, mostra que siso n„o tem.",
" sinal de bom senso e prudˆncia restringir os gastos aos limites do que se ganha.",

"Quem muito abarca pouco abra‡a.",
"Quem se entrega a muitas actividades, de poucas d  conta.",

"Quem n„o arrisca n„o petisca.",
"Quem n„o se aventura a uma empresa, n„o colhe os resultados.",

"Quem n„o deve n„o teme.",
"Quem n„o pratica o mal, n„o tem motivos para preocupa‡”es ou receios.",

"Quem n„o tem c„o ca‡a com gato.",
"Cada qual serve-se dos recursos que tem … m„o.",

"Quem nunca comeu melado, quando come lambuza-se.",
"Quem n„o est  habituado …s coisas boas, n„o sabe como us -las quando as consegue.",

"Quem o alheio veste, na pra‡a o despe.",
"Quem se vale do que n„o lhe pertence, est  sujeito a vexames.",

"Quem pode o mais pode o menos.",
"Quem tem capacidade para uma coisa maior, tem-na tamb‚m para uma coisa menor.",

"Quem porfia mata a ca‡a.",
"Quem preserva alcan‡a o que pretende.",

"Quem quer vai, quem n„o quer manda.",
"Dificilmente uma pessoa que se interessa por fazer uma coisa, encontra quem o fa‡a com o mesmo empenho.",

"Quem tem boca n„o manda soprar.",
"Quem quer fazer alguma coisa dif¡cil ou perigosa, n„o deve mandar que outrem o fa‡a.",

"Quem tem boca vai a Roma.",
"Pela for‡a de perguntar, de pedir informa‡”es, chega-se aonde se quer, consegue-se o que se pretende.",

"Quem tem telhado de vidro n„o atira pedras ao do vizinho.",
"Quem tem motivos para ser censurado n„o deve censurar os outros.",

"Quem tudo quer tudo perde.",
"Quem ambiciona mais do que pode perde at‚ o que tem.",

"Quem semeia ventos colhe tempestades.",
"Quem faz provoca‡”es est  sujeito …s suas consequˆncias.",

"Quem vˆ caras n„o vˆ cora‡”es.",
"N„o se pode julgar pessoas e coisas s¢ pela aparˆncia, pois as atitudes nem sempre reflectem as inten‡”es.",

"Querer ‚ poder.",
"A vontade firme converte-se em for‡a e capacidade.",

"Ri melhor quem ri por £ltimo.",
"A instabilidade da sorte n„o permite que se tenha por definitivo um triunfo alcan‡ado, zombando de quem n„o o alcan‡ou.",

"Roma n„o se fez num dia.",
"As grandes realiza‡”es exigem tempo e vagar.",

"Se queres conhecer o vil„o, p”e-lhe uma vara na m„o.",
" no exerc¡cio da autoridade que se manifestam com frequˆncia os esp¡ritos mesquinhos.",

"Tal pai, tal filho.",
"Os filhos herdam os caracteres dos pais, tendem a ser como eles.",

"Tempo de guerra, mentira como terra.",
"O estado de esp¡rito de povo, em ocasi„o de conflitos, n„o permite serenidade na aprecia‡„o dos factos, o que leva a exageros e deturpa‡”es da verdade.",

"Tempo ‚ dinheiro.",
"Do bom uso do tempo colhem-se vantagens.",

"Um abismo chama outro.",
"Um v¡cio acarreta outro.",

"Uma m„o lava a outra e as duas lavam o rosto.",
"A coopera‡„o entre os indiv¡duos produz resultados que um s¢ n„o conseguiria.",

"Uma ovelha m  p”e o rebanho a perder.",
"Um mau companheiro pode perverter os membros de um grupo ou p“r em risco a sua reputa‡„o.",

"Um homem prevenido vale por dois.",
"Uma pessoa avisada est  mais preparada para livrar-se de dificuldades.",

};


void pro_printf(char *s)
{
    register int i;

    for(i=0; s[i]!='\0'; i++){
	 if(wherex()>70 && s[i]==32)
	      printf("\n\r");

	 printf("%c", s[i]);
    }
}


int main(int argc, char *argv[])
{
    int i, pro;


    if(argc==2){
	 if(argv[1][0] == '/' && (argv[1][1] == 'T' || argv[1][1] == 't')){
	      printf("\nLista de prov‚rbios\n");
	      printf("-------------------\n");
	      for(i=0; i!=PROVERBIOS*2; i+=2){
		   printf("\n\r");
		   pro_printf(p[i]);
		   printf("\n\r");
		   pro_printf(p[i+1]);
		   printf("\n\r");
	      }
	      return 0;
	 }
	 else{
	      printf("\nProv‚rbios Portugueses   v1.0\n");
	      printf("\nUso:");
	      printf("\n\tpp         para gerar um prov‚rbio");
	      printf("\n\tpp /T      para visualizar todos os prov‚rbios\n");
	      return -1;
	 }
    }

    if(argc==1){
	 randomize();

	 pro = random(PROVERBIOS) * 2;

	 printf("\n\r-> %s");
	 pro_printf(p[pro]);
	 printf("\n\r:  ");
	 pro_printf(p[pro+1]);
	 printf("\n\r");

	 return 0;
    }
    else{
	 printf("\nProv‚rbios Portugueses   v1.0\n");
	 printf("\nUso:");
	 printf("\n\tpp         para gerar um prov‚rbio");
	 printf("\n\tpp /T      para visualizar todos os prov‚rbios\n");
	 return -1;
    }
}