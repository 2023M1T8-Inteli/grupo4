# Inteli - Instituto de Tecnologia e Liderança 

<p align="center">
<a href= "https://www.inteli.edu.br/"><img src="https://www.inteli.edu.br/wp-content/uploads/2021/08/20172028/marca_1-2.png" alt="Inteli - Instituto de Tecnologia e Liderança" border="0"></a>
</p>

# Moralética

## Group for()

## Integrantes: Gabrielle Dias Cartaxo, Gustavo Wagon Widman, Izadora Luz Rodrigues Novaes, Matheus Ferreira Mendes, Olin Medeiros Costa, Thomas Reitzfeld.

## Descrição

O desenvolvimento desse jogo tem como objetivo suprir as necessidades do nosso cliente, V. Tal, em gamificar o atual processo de treinamento do código de ética da empresa. A gamificação visa tornar melhor a didática do treinamento e dinamizar a experiência do colaborador ao longo do processo. Além disso, a ideia também é ter uma maior aderência e aumentar o conhecimento referente ao código de ética e evitar infrações a esse código.
É um jogo mundo aberto e singleplayer com modo história, desenvolvido em 2.5D. Além disso, o jogo conta com tasks e mini games interativos e recreativos, para desenvolver o conhecimento do usuário acerca dos temas propostos pela V. Tal.

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
Encontre o index.html na pasta executáveis e execute-o como uma página WEB (através de algum browser).

## 💻 Configuração para Desenvolvimento

1 - Faça o download do GODOT e deste repositório.
2 - Abra o GODOT, ao ser prontificado clique em IMPORTAR.
3 - Selecione a pasta onde descompactou este repositório.

Para abrir este projeto você necessita das seguintes ferramentas:

-<a href="https://godotengine.org/download">GODOT</a>

## 🗃 Histórico de lançamentos

A cada atualização os detalhes devem ser lançados aqui.

* 0.1.3.1 - 27/02/2023
    * MUDANÇA: Recomentar scene_transition.gd 
      Mudar animation smoothing do player 
* 0.1.4.0 - 27/02/2023
    *  Adicionar task DrunkWireTask
    *  Adicionar logo do Jogo
    *  Adicionar 2 TileMaps (Thomas)
    *  Atualizar Versao para 0.1.4.0
    *  Remover executaveis para preparar export novo
* 0.1.4.1 - 28/02/2023
    *  Add Cena Preludio
    *  Add efeitos bebado
    *  Add Predio thomas
* 0.1.5.0 - 01/03/2023
  -  Inserir dialogo da gabi no game
    *  Copiar e editar cenas
    *  Testar todos dialogos
  -  Inserir musica do thomas no limbo
    *  Diminuir som dos audios
    *  Testar
  -  Inserir setinhas apertadas do Thomas
    *  Criar variaveis globais de botoes apertados/nao apertados
    *  Linkar variaveis do script player com o script do GUI atraves de um script global
    *  Alinhar e posicionar sprites to thomas em cima do joystick existente
    *  Testar compatibilidade com cenas e dispositivos
  -  Extras
    *  Retirar algumas funcoes print() dentro do codigo que foram utilizadas para debugging
    *  Renomear cena do limbo de "Main Scene" para LImbo1
    *  Renomear script CanvasLayer.gd (anexado a GUI) para GUI.gd
    *  Remover exports velhos em preparacao ao export da nova versao alpha
## 📋 Licença/License

<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://github.com/Spidus/Teste_Final_1">MODELO GIT INTELI</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://www.yggbrasil.com.br/vr">INTELI, VICTOR BRUNO ALEXANDER ROSETTI DE QUIROZ</a> is licensed under <a href="http://creativecommons.org/licenses/by/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">Attribution 4.0 International<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"></a></p>

## 🎓 Referências

Aqui estão as referências usadas no projeto.

1. <https://github.com/iuricode/readme-template>
2. <https://github.com/gabrieldejesus/readme-model>
3. <https://creativecommons.org/share-your-work/>
4. <https://freesound.org/>
5. Músicas por: <a href="https://freesound.org/people/DaveJf/sounds/616544/"> DaveJf </a> e <a href="https://freesound.org/people/DRFX/sounds/338986/"> DRFX </a> ambas com Licença CC 0.
