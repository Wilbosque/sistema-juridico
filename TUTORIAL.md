# Sistema Jurídico — Guia de Configuração e Manutenção

Este guia ensina, do zero, a colocar o sistema no ar com banco de dados na nuvem
(Supabase) e a mantê-lo. **Não precisa saber programar** — é só seguir os passos
na ordem.

> **Tempo estimado na primeira vez:** 30 a 45 minutos.

---

## O que mudou (resumo)

| Antes | Agora |
|-------|-------|
| Senhas escritas no código (qualquer um via) | Login de verdade (Supabase Auth) |
| Dados só no navegador de cada um | Dados num banco na nuvem, **compartilhados** |
| Trocar de PC = perder tudo | Dados salvos para sempre, acesso de qualquer lugar |
| Sem backup real | Banco com backup automático do Supabase |

**Arquivos do projeto:**

- `index.html` — tela de login
- `Sistema.html` — o sistema em si
- `config.js` — onde você cola as 2 chaves do Supabase (passo 3)
- `supabase-schema.sql` — cria as tabelas do banco (passo 2)
- `migrar-dados.html` — leva os dados antigos pro banco (passo 6)
- `TUTORIAL.md` — este guia

---

## Passo 1 — Criar a conta e o projeto no Supabase

1. Acesse **https://supabase.com** e clique em **Start your project**.
2. Faça login (o mais fácil é **Continue with GitHub**, usando a mesma conta do repositório).
3. Clique em **New project**.
4. Preencha:
   - **Name:** `sistema-juridico`
   - **Database Password:** clique em **Generate a password** e **GUARDE essa senha**
     num lugar seguro (gerenciador de senhas). É a senha do banco — diferente da senha de login do sistema.
   - **Region:** escolha **South America (São Paulo)** se aparecer (fica mais rápido no Brasil).
5. Clique em **Create new project** e aguarde 1–2 minutos enquanto ele é criado.

---

## Passo 2 — Criar as tabelas do banco

1. No menu lateral do Supabase, abra o **SQL Editor** (ícone `</>`).
2. Clique em **New query** (ou **+**).
3. Abra o arquivo `supabase-schema.sql` num editor de texto, **copie todo o conteúdo**
   e cole na janela do SQL Editor.
4. Clique em **Run** (ou aperte `Ctrl+Enter`).
5. Deve aparecer **"Success. No rows returned"**. Pronto — as tabelas foram criadas.

> Se rodar de novo por engano, não tem problema: o script é seguro para repetir.

---

## Passo 3 — Pegar as 2 chaves e colar no `config.js`

1. No menu lateral, vá em **Project Settings** (engrenagem) → **API**
   (em versões novas pode aparecer como **Data API** e **API Keys**).
2. Você vai precisar de **dois valores**:
   - **Project URL** — algo como `https://abcdefgh.supabase.co`
   - **anon public** (a chave pública/"publishable") — um texto longo começando com `eyJ...`
3. Abra o arquivo **`config.js`** num editor de texto e cole nos lugares indicados:

   ```js
   const SUPABASE_URL      = "https://abcdefgh.supabase.co";   // <- sua Project URL
   const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6...";  // <- sua chave anon public
   ```

4. Salve o arquivo.

> ⚠️ **Use APENAS a chave `anon public`.** NUNCA cole aqui a chave **`service_role`**
> (essa é secreta e dá acesso total ao banco). A `anon public` é feita para ficar no
> navegador — quem protege os dados é o login + as regras de segurança que o passo 2 criou.

---

## Passo 4 — Criar os usuários (e-mail + senha)

1. No menu lateral do Supabase, vá em **Authentication** → **Users**.
2. Clique em **Add user** → **Create new user**.
3. Preencha **Email** e **Password** da pessoa e **marque a opção "Auto Confirm User"**
   (assim não precisa confirmar por e-mail).
4. Clique em **Create user**.
5. Repita para cada pessoa (ex.: Wilquer e Vivian).

**Senhas sugeridas:** escolha senhas **novas e fortes**. As senhas antigas
(`420621$` e `viviaN19$`) ficaram públicas no código antigo — **considere-as
queimadas** e não as reutilize aqui nem em outros lugares.

> Para **trocar a senha** de alguém depois: Authentication → Users → clique nos `…`
> ao lado da pessoa → **Reset password** (ou edite o usuário).

---

## Passo 5 — Publicar (deploy) no GitHub

O site é hospedado de graça pelo GitHub Pages. Basta atualizar os arquivos no repositório.

**Pela internet (mais simples):**

1. Abra o repositório no GitHub: **https://github.com/Wilbosque/sistema-juridico**
2. Para cada arquivo (`index.html`, `Sistema.html`, `config.js`, `migrar-dados.html`,
   `supabase-schema.sql`, `TUTORIAL.md`), clique em **Add file → Upload files**,
   arraste a versão nova e clique em **Commit changes**. (Pode arrastar todos de uma vez.)
3. O GitHub Pages republica sozinho em ~1 minuto.
4. Acesse o endereço do site (algo como `https://wilbosque.github.io/sistema-juridico/`)
   e teste o login com um usuário criado no passo 4.

> O `config.js` **deve** ir junto com a URL e a chave já preenchidas — sem ele o sistema não conecta.

---

## Passo 6 — Migrar os dados antigos (uma vez só)

Os dados que já existiam ficavam guardados **dentro do navegador de cada pessoa**.
Para levá-los ao banco:

**Antes de tudo — exporte um backup de cada navegador que tinha dados:**

1. Na pessoa/computador que usava o sistema, abra a versão antiga **antes de atualizar**,
   ou se já atualizou, abra o sistema e clique em **Exportar backup** (gera um arquivo `.json`).
   - ⚠️ Como os dados não eram compartilhados, **o Wilquer e a Vivian podem ter dados
     diferentes**. Exporte um backup em **cada** navegador/computador que era usado.

**Depois, migre:**

2. Acesse `migrar-dados.html` no site (ex.: `https://wilbosque.github.io/sistema-juridico/migrar-dados.html`).
3. Entre com e-mail e senha.
4. **Opção A (recomendada):** selecione o arquivo de backup `.json` e clique em **Migrar do arquivo**.
5. Repita para cada arquivo de backup (de cada pessoa).
6. Quando aparecer **"✓ Migração concluída"**, está pronto. Abra o `Sistema.html` e confira.

> Se você não exportou e os dados ainda estão no navegador, use a **Opção B
> ("Migrar deste navegador")** — mas só funciona se você ainda **não abriu a versão
> nova do sistema** naquele navegador (senão o cache já pode ter sido atualizado).

---

## Uso no dia a dia

- **Entrar:** abra o site → digite e-mail e senha.
- **Sair:** botão de logout no rodapé da barra lateral.
- Tudo que você cria/edita/exclui é salvo **na hora** no banco e aparece para a outra pessoa
  (basta atualizar a página dela com F5).
- **Sem internet:** o sistema mostra os últimos dados que viu (somente leitura) e avisa.
  Quando a internet volta, grava normalmente.

---

## Segurança — o essencial

✅ **Pode** deixar o `config.js` no código público (URL + chave `anon`). É seguro por design.
✅ As regras **RLS** (passo 2) garantem que **só quem está logado** acessa os dados.

❌ **Nunca** coloque a chave `service_role` no `config.js` nem em qualquer arquivo do site.
❌ **Nunca** reutilize as senhas antigas (`420621$`, `viviaN19$`) — elas vazaram no código antigo.
❌ **Nunca** compartilhe a senha do banco (passo 1) — guarde-a só para administração.

**Backup:** o Supabase já faz backup automático. Mesmo assim, é bom hábito clicar em
**Exportar backup** dentro do sistema de vez em quando e guardar o `.json`.

---

## Resolução de problemas

| Sintoma | O que verificar |
|--------|------------------|
| "E-mail ou senha incorretos" sendo que está certo | O usuário foi criado no passo 4? Marcou **Auto Confirm User**? |
| Tela fica em branco / não conecta | O `config.js` tem a **Project URL** e a **chave anon** corretas e salvas? |
| "Sem conexão — exibindo dados em cache" | Sem internet, ou URL/chave erradas no `config.js`. |
| Dados antigos não aparecem | Falta rodar a **migração** (passo 6) com o backup daquele navegador. |
| Aviso "dados locais ainda não migrados" | Abra `migrar-dados.html` e faça o passo 6. |
| Erro ao gravar no banco | As tabelas foram criadas (passo 2)? O usuário está logado? |

**Onde olhar erros técnicos:** no navegador, aperte **F12** → aba **Console**.
As mensagens em vermelho ajudam a identificar o problema.

---

## Contatos das ferramentas

- **Site (GitHub Pages):** https://github.com/Wilbosque/sistema-juridico
- **Banco de dados (Supabase):** https://supabase.com/dashboard
- **Documentação do Supabase:** https://supabase.com/docs
