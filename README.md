# Inteli - Instituto de Tecnologia e Liderança 

<p align="center">
<a href= "https://www.inteli.edu.br/"><img src="https://www.inteli.edu.br/wp-content/uploads/2021/08/20172028/marca_1-2.png" alt="Inteli - Instituto de Tecnologia e Liderança" border="0"></a>
</p>

# Moralética

## Group for()

## Integrantes: Gabrielle Dias Cartaxo, Gustavo Wagon Widman, Izadora Luz Rodrigues Novaes, Matheus Ferreira Mendes, Olin Medeiros Costa, Thomas Reitzfeld.

## Descrição

O desenvolvimento desse jogo tem como objetivo suprir as necessidades do nosso cliente, V.tal, em gamificar o atual processo de treinamento do código de ética da empresa. A gamificação visa tornar melhor a didática do treinamento e dinamizar a experiência do colaborador ao longo do processo. Além disso, a ideia também é ter uma maior aderência e aumentar o conhecimento referente ao código de ética e evitar infrações a esse código.
É um jogo mundo aberto e singleplayer com modo história, desenvolvido em 2.5D. Além disso, o jogo conta com tasks e mini games interativos e recreativos, para desenvolver o conhecimento do usuário acerca dos temas propostos pela V.tal.

° Jogo mundo aberto, singleplayer, jornada do herói em 2.5D que tem como objetivo gamificar o treinamento de ética existente da V.Tal;

° O jogo se passa em uma cidade fictícia e como principais cenários temos o limbo e a empresa;

° Durante o jogo, o protagonista, Zé, não é o único personagem jogável, já que nosso herói vivencia diversas vidas ao longo do game. Além do Zé temos o fantasminha do Zé, a Tereza, o Jonas e o João Vicente, todos eles sendo jogáveis, um de cada vez;

° O objetivo do jogo é tornar o aprendizado mais interativo e dinâmico, proporcionando um aprendizado mais eficiente de forma gamificada.


<br><br>

## 🛠 Estrutura de pastas

|-->docs<br>
|-->documentos<br>
  &emsp;|-->antigos<br>
  &emsp;|GDD.docx ou Documentação.docx<br>
|-->executáveis<br>
  &emsp;|-->windows<br>
  &emsp;|-->android<br>
  &emsp;|-->HTML<br>
|-->imagens<br>
|-->src/godot-game<br>
|.gitattributes<br>
|.gitignore<br>
|README.md<br>
|README.md.bak<br>


Descrição das funções das pastas:

<b>docs</b>: Aqui serão colocados os arquivos compilados em HTML do jogo.
<b>documentos</b>: Aqui estarão todos os documentos do projeto, mas principalmente o <b>GDD (Game Design Document)/Documentação do Sistema</b>. Há uma pasta <b>antigos</b> onde estarão todas as versões antigas da documentação.

<b>executáveis</b>: Aqui estarão todos os executáveis do jogo, prontos para rodar. Há no mínimo 3 pastas, uma para binários <b>Windows</b>, uma para binários <b>android</b> e uma para a <b>Web/HTML</b>

<b>imagens</b>: Algumas imagens do jogo/sistema e logos prontos para serem utilizados e visualizados.

<b>src</b>: Nesta pasta irá todo o código fonte do jogo/sistema, pronto para para ser baixado e modificado.

## 🛠 Instalação

<b>Android:</b>

Faça o Download do JOGO.apk no seu celular.
Execute o APK e siga as instruções de seu telefone.

<b>Windows:</b>

Não há instalação! Apenas executável!
Encontre o JOGO.exe na pasta executáveis e execute-o como qualquer outro programa.

<b>HTML:</b>

Não há instalação!
Encontre o index.html na pasta executáveis e execute-o como uma página WEB (através de algum browser) ou aproveite do nosso GitPages: https://2023m1t8-inteli.github.io/grupo4/

## 💻 Configuração para Desenvolvimento

1 - Faça o download do GODOT 3.5.x e deste repositório.
2 - Abra o GODOT, ao ser prontificado clique em IMPORTAR.
3 - Selecione a pasta onde descompactou este repositório.

Para abrir este projeto você necessita das seguintes ferramentas:

-<a href="https://godotengine.org/download">GODOT</a>

## 🗃 Histórico de lançamentos

A cada atualização os detalhes devem ser lançados aqui.

* 0.1.3.1 - 27/02/2023
    * MUDANÇA: Recomentar scene_transition.gd;
      Mudar animation smoothing do player. 
      
* 0.1.4.0 - 27/02/2023
    *  Adicionar task DrunkWireTask;
    *  Adicionar logo do Jogo;
    *  Adicionar 2 TileMaps;
    *  Atualizar Versao para 0.1.4.0;
    *  Remover executaveis para preparar export novo.

* 0.1.4.1 - 28/02/2023
    *  Adicionar cena de prelúdio;
    *  Adicionar efeitos de bêbado;
    *  Adicionar prédio no mapa.

* 0.1.5.0 - 01/03/2023
  -  Inserir diálogos no jogo:
    *  Copiar e editar cenas;
    *  Testar todos diálogos.
  -  Inserir música no limbo:
    *  Diminuir som dos áudios;
    *  Testar.
  -  Inserir setinhas apertadas:
    *  Criar variáveis globais de botões apertados/não apertados;
    *  Linkar variáveis do script player com o script do GUI através de um script global;
    *  Alinhar e posicionar sprite em cima do joystick existente;
    *  Testar compatibilidade com cenas e dispositivos.
  -  Extras:
    *  Retirar algumas funções print() dentro do código que foram utilizadas para debugging;
    *  Renomear cena do limbo de "Main Scene" para LImbo1;
    *  Renomear script CanvasLayer.gd (anexado a GUI) para GUI.gd;
    *  Remover exports velhos em preparação ao export da nova versão alpha;

* 0.1.5.1 - 02/03/2023
    * Adicionar "flash" de setinhas quando volta uma frase do diálogo. (Aplicado em todas as caixas de diálogo criadas até agora);
    * Deletar TaskExec1 (Protótipo falho de uma task "quiz").

* 0.1.5.2 - 02/03/2023
    * Pequenos Patches:
    - Mudar levemente o código da title screen;
    - Polir código do player.

* 0.1.5.3 - 03/03/2023
    * Inicio da adição da parte administrativa;
    * Implementação da task quiz, que ainda não funciona.

* 0.1.5.4 - 03/03/2023 
    * Conserto da task do quiz.
    
* 0.1.5.5 - 03/03/2023
    * Últimos patches na task de quiz.
    
* 0.1.5.6 - 06/03/2023
    * Adicionar segunda task de quiz.
    
* 0.1.6.0 - 06/03/2023
    * Adicionar cena temporária em cima do poste;
    * Adicionar alguns tilemaps/tilesets da internet.
    * Adicionar funcionalidade botão de interação (Na Wiretask e para ir para cena em cima do poste);
    * Apagar exports velhos em preparação para nova versão alpha.
    
* 0.1.6.1 - 06/03/2023
    * Se o jogador já viu o diálogo do limbo uma vez, pula diretamente para a cena da cidade.
    
* 0.1.7.0 - 07/03/2023
    * Refinar cenas já existentes e ordenar tudo.
    * Title Screen -> Prelude -> PosteCima (explode) -> limbo -> cidade -> adm
    
* 0.2.0.0 - 07/03/2023
   * NEW BETA:
   * Animação adicionada.
   * Historia flui:
    * Title Screen -> Anim -> Prelude -> PosteCima (explode e tem barulho agr) -> Limbo (sons e musicas sincronizados) -> cidade -> adm (opcional)
    * Caso o player já passou do diálogo do limbo:
    * TItle Screen -> Cidade -> ADM
 
 * 0.2.1.0 - 08/03/2023
    * Adicionar setinha guia;
    * Adicionar alerta;
    * Acelerar animação;
    * Tentativa falha de posSave ao sair do jogo pela tela de pause (em desenvolvimento).
  
* 0.2.1.1 - 09/03/2023
    * Adicionar botão para pular animação.
    
* 0.2.1.3 - 09/03/2023
    * Alterar o diálogo do limbo.
    
* 0.2.1.4 - 09/03/2023
    * Editar bêbado (vertigem);
    * Começar a editar a Wiretask bêbada (EM PROGRESSO).
    
* 0.2.2.0 - 09/03/2023
    * Mudar controles para touch screen.
     
* 0.2.2.1 - 10/03/2023
    * Adicionar prompt ao entrar no prelúdio;
    * Retirar botão controles da title screen.
    
* 0.2.3.0 - 10/03/2023
    * Consertando erros de merge;
    * Aprimorando sistema de interação com botões touch;
    * Mudar sprite da seta guia;
    * Adicionar sprites Jonas e Tereza;
    * Debugging e polimentos finais para entrega.
    
* 0.2.4.0 - 10/03/2023
    * Refazer/reajustar animações;
    * Animação depois explosão, antes do limbo (hospital);
    * Reexportar jogo para gitpages.
    
* 0.2.4.1 - 10/03/2023
    * Mudar levemente os volumes dos sons dentro do jogo;
    * Mudar levemente o tamanho da hitbox do player para ser mais coerente com o tamanho real das sprites;
    * Mudar levemente a animação do Zé no hospital;
    * Consertar bug que fazia com que o barulho de explosão repetia varias vezes enquanto o jogo estava na cena de hospital;
    * Jogo salva em qual cena estava e onde o jogador saiu (se ja passou da cena do limbo): se vai na tela de pause dentro da tela administrativa, por exemplo, quando voltar ao jogo volta pro msm lugar dentro da tela administrativa.
    
* 0.2.4.2 - 10/03/2023
    * Modificar final temporário (declarado na cena adm apos 3 segundos)´;
    * Export gitpages.
    
* 0.2.4.4 - 10/03/2023
    * Comentários e polimentos finais do jogo para entrega de sprint;
    * Adicionar plugin para RichPresence de discord.

* 0.2.4.5 - 10/03/2023
    * Adicionar salvaguarda na cena Administrativo para consertar um erro que acontecia caso o jogador interagisse com o botão de elevador antes de um "yield" acabar.
    
* 0.2.4.6 - 12/03/2023
    * Adicionar bootsplash;
    * Testar exports android;
    * Exports gitpages.
    
* 0.2.5.0 - 12/03/2023
    * Modificação da cena administrativa;
    * Importando Zezinho e Terezinha, otimizando script player e adicionando função de direção das sprites;
    * Otimização e polimentos da caixa de diálogo;
    * Consertando merge ruim - não está tudo consertado ainda;
    * Uploads gitpages e exports normais (por versão alpha).
    
* 0.2.5.1 - 13/03/2023
    * Consertar bug ao entrar na cena administrativa (relacionado a posição padrão do player);
    * Refinar animações das sprites de player e adicionar variável exportável que controla a velocidade do player, individualmente por cena (padrão 350, na tela administrativa está como 250 agora);
    * Velocidade de animação de sprite representa 10fps - (velocidade atual / velocidade padrão);
    * Export GitPages.
    
* 0.2.5.2 - 13/03/2023
    * Editar (parcialmente) hitbox do player e hitboxes da cena administrativa;
    * Adicionar addon Aseprite;
    * Adicionar funcionalidade de mexer no tamanho do player por cena.
    
* 0.2.5.3 - 13/03/2023
    * Arrumar sprites (filtro desativado).
    
* 0.2.6.0 - 15/03/2023
    * Animação ingame da reunião da tereza (executivo);
    * Integrar primeiro quiz após reunião Tereza (executivo);
    * Polir quiz e suas funções;
    * Polir player, objetivos, etc.

* 0.2.6.1 - 15/03/2023
    * Consertar merge.
    * Polir cenas prelude e postecima, arrumar alguns bugs;
    * Export gitpages.
  
* 0.2.7.0 - 15/03/2023
    * Aperfeiçoar cena postecima e prelúdio (toques finais);
    * Adicionar função objectiveAnim (zoom in no objetivo ativo e renderiza texto respectivo ao objetivo/descricao);
    * Aperfeiçoar script executivo;
    * Aperfeiçoar animação da reunião;
    * Adicionar função de animação "assédio";
    * Adicionar equipe de compliance e seu diálogo respectivo (ocorre após assédio);
    * Finalizar quiz1 e aperfeiçoar/polir seu script;
    * Adicionar quiz2 (PARCIAL, NÃO FUNCIONA DIREITO AINDA);
    * Export GitPages.
    
* 0.3.0.0 - 16/03/2023
    * FINALIZAR TOTALMENTE CENA EXECUTIVA, INCLUINDO O QUIZ FINAL!
    * Criar limbo2 com 2 tasks dailys e 2 diálogos;
    * Separar a cena cidade em duas (tecnicamente), para executivo e administrativo;
    * Refinar e polir cena prelúdio e administrativa para melhor apresentatividade;
    * Outros patches pequenos aleatórios.
    
* 0.3.0.1 - 16/03/2023
    * Juntar todas os commits do dia;
    * Export GitPages.
    
* 0.3.1.0 - 17/03/2023
    * Adicionar abordagem do chefe do jonas no início da cena administrativo;
    * Polir partes da cena do apartamento (criar script novo, clonado do de cena administrativa, modificar o script do apartamento para poder rodar e modificar tamanho e velocidade do player nessa cena, além de zoom da câmera);
    * Modificar velocidade de animação de andar do player (em algumas cenas ficava muito e lento parecia que o player estava deslizando).
 
* 0.3.1.2 - 17/03/2024
    * Alteração das descrições dos objetivos na tela.
    
* 0.3.2.0 - 17/03/2023
    * Adicionar primeira task do administrativo (ataque hacker, consultar com eq. seguranca de info);
    * Aplicar sprite nova de acessibilidade para task dos fios;
    * Consertar merge do script da cidade.
    
* 0.3.2.1 - 18/03/2023
    * Limbo3 com dailies 3 e 4 (nomeadas 4 e 5) implementado;
    * Export GitPages.
    
* 0.3.2.3 - 18/03/2023
    * Adicionar Limbo4;
    * Exportar para gitpages.
    
* 0.3.3.0 - 20/03/2023
    * Polir push do thomas (task linkedin);
    * Task arrumar coisas;
    * Abordagem /chefe final.
    
* pre0.4.0.0 - 20/03/2023
    * Transição de cena pro limbo e consertar pos-abordagem na cena adm;
    * Iniciar a preparação da cena técnico para introdução das tasks novas.
    
* pre0.4.0.1 - 21/03/2023
    * Consertar áudio no game, especialmente o barulho de explosão na cena prelúdio;
    * Revisão, correção e reforma em todos os diálogos e quizes.
    
* pre0.4.0.2 - 21/03/2023
    * Adicionar primeira "Task" técnico (abordagem chefe);
    * Polir levemente cena técnico como preparações para implementação das novas tasks;
    * Iniciar Task1 Técnico (amb trabalho, brejinha).
    
* pre0.4.1.0 - 21/03/2023
    * Finalizar task1 técnico (brejinha);
    * Preparar task2 técnico.
    
* pre0.4.1.2 - 22/03/2023
    * Finalizar task blogueira (TASK2TEC).
    
* pre0.4.1.3 - 22/03/2023
    * Consertar cenas técnico e apartamento (corrompidas no push).
    
* pre0.4.2.0 - 22/03/2023
    * Finalizar todas as tasks do técnico.
    
* 0.5.0.0 - 22/03/2023
    * (PULAMOS DE VER pre0.4 PRA 0.5)!
    * Consertar bug hitbox da interação final com o chefe (TEC;
    * Consertar hitbox cadeiras (Exec e ADM);
    * Consertar task3 EXEC (Timer);
    * Consertar Reunião EXEC (Posicionamento de Câmera);
    * Finalizar e polir técnico;
    * Adicionar Jaoãozinho (p/ TEC);
    * Consertar bug de câmera que tava acontecendo com o Player em algumas cenas;
    * Consertar um bug q tava acontecendo com a sprite do joninhas;
    * Consertar task linkedin ADM (agora tem novas texturas);
    * Implementar sprite checkbox;
    * Export GitPages.
    
* 0.5.0.1 - 22/03/2023 
    * Consertar personagem q aparecia no postecima2;
    * Consertar balão de obj na cena TEC (que aparecia em cima do poste);
    * Juntar pushes;
    * Alteração nas perguntas dos quizes.
    
* 0.5.1.0 - 23/03/2023
    * Adicionar animações ComecoTereza e ComecoJonas;
    * Consertar bugs da Van (TEC);
    * Consertar bugs da Task1TEC (Area2D);
    * Adicionar assediador (a sprite);
    * Consertar boa parte dos warns do console;
    * Consertar textura botão pause (tava quebrada faz mto tempo).
    
* 0.5.1.1 - 23/03/2023
    * Juntar commits e solucionar conflitos;
    * Refazer sprites do assediador (tinha quebrado);
    * Export gitpages.
    
* 1.0.0.0 - 24/03/2023
    * Adicionar filtros bonitinhos nos diálogos para facilitar leitura mas manter foco no jogo;
    * Checar incompatibilidades com funções velhas e desativar algumas delas (incluindo o botão SAIR do GUI, que usava um método de salvar posição velho que será atualizado na Sprint 5, mas por enquanto deve permanecer desligado se não quebra o jogo...);
    * Consertar filtro pre-existente nos quizzes;
    * Modificar hitboxes de cadeiras/mesas que faltavam, padronizando o jogo e providenciando uma experiência mais suave;
    * Inserir NPCs novos em TEC, ADM e EXEC/EXECFake (falta blogueira e chefe ADM);
    * Aperfeiçoar Task0TEC (reunião chefe) com os novos NPCs;
    * Consertar bug do ADM na abordagem final do chefe;
    * Consertar bug onde o pause do GUI sobreescrevia o Global.canMove, resultando em algumas situações bem engracadas onde o player podia andar;
    * Renovar totalmente a cena Reincarn (antes era o "aqui tem mais", agora, os créditos do jogo!);
    * Desativar botão jogar depois que o player passa pelos créditos (vai ser implementado um "replay" ainda);
    * Consertar inconsistências no movimento da câmera em algumas cenas;
    * Consertar bug na cena apartamento onde o player podia interagir várias vezes com o roteador antes do "yield" acabar;
    * Consertar textura dos comentarios do LInkedIN;
    * Fazer o botão de pause ficar invisível em lugares onde ele não deveria estar visível ou quebrava alguma coisa (tipo numa tela de computador ou durante uma animação de objetivo);
    * Consertar um bug com todas as tasks do ADM que incluiam subir para o andar EXECFake, onde o player podia subir de volta infinitas vezes;
    * Adicionar elevador com andar #2 para os andares EXEC/EXECFake, manter elevador com andar #3 para ADM;
    * Adicionar acentos na prompt de ataque hacker;
    * Corrigir capitalização em algumas caixas de dialogo;
    * Export GitPages.
    * EBAAAAAA VERSAO 1.0.0.0 :confetti_ball: !!
    
* 1.0.0.1 - 23/03/2023
    * Mini patch: visibilidade do balão de exclamação na eq de compliance no EXEC.

*1.0.0.2 - 23/03/2023
    * Consertar hitbox do prédio (CIDADE);
    * Consertar hitbox da van (TEC);
    * Desacelerar scrollspeed créditos;
    * Reverter tela comentários.

*1.0.0.4 - 23/03/2023
    * Correções na parte escrita apontada pelos parceiros.


## 📋 Licença/License

<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://github.com/Spidus/Teste_Final_1">MODELO GIT INTELI</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://www.yggbrasil.com.br/vr">INTELI, VICTOR BRUNO ALEXANDER ROSETTI DE QUIROZ</a> is licensed under <a href="http://creativecommons.org/licenses/by/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">Attribution 4.0 International<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"></a></p>

## 🎓 Referências

Aqui estão as referências usadas no projeto.

1. <https://github.com/iuricode/readme-template>
2. <https://github.com/gabrieldejesus/readme-model>
3. <https://creativecommons.org/share-your-work/>
4. <https://freesound.org/>
5. Músicas por: <a href="https://freesound.org/people/DaveJf/sounds/616544/"> DaveJf </a> e <a href="https://freesound.org/people/DRFX/sounds/338986/"> DRFX </a> ambas com Licença CC 0.
