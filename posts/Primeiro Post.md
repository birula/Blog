Olá desenvolvedores, é com prazer que nosso grupo de estudo coloca este blog no ar hoje, desenvolvemos a ferramenta deste blog hoje mesmo, e vamos falar neste post sobre a construção dele.

Começamos a trabalhar as 9:00 am e o objetivo era publicar até as 16:00. Antes de iniciar o desenvolvimento definimos as atividades que deveriam ser executadas para ter o blog publicado. Segue a nossa lista de atividades original abaixo

-	Pesquisas biblioteca para fazer highlights de código nos posts
-	Criar página “Sobre”
-	Baixar Layout
-	Cria Home
-	Criar página de posts
-	Criar página de login e controle de autenticação
-	Gravar usuários diretamente no banco
-	Publicar
-	Aplicar o layout no front-end

O blog foi desenvolvido em Rails 4.0 e para fazer a publicação sem termos que nos preocupar com servidores e tudo mais nós usamos o [Heroku][lnk-heroku].

Para criar a aplicação baseada em nosso template fizemos:
```
 rails new -m  template.rb
```
Após executar esse código foi criada nossa aplicação.


[lnk-heroku]: https://www.heroku.com/

