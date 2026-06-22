# Sistema Jurídico — Wilquer Bosque

Sistema de gestão de processos, prazos e suspensões. Front-end estático
(HTML/JS) hospedado no GitHub Pages, com banco de dados e autenticação no
**Supabase** (PostgreSQL + Auth + RLS).

## Estrutura

| Arquivo | Função |
|---------|--------|
| `index.html` | Tela de login (Supabase Auth — e-mail + senha) |
| `Sistema.html` | Aplicação principal |
| `config.js` | URL e chave pública do Supabase (preencher antes de usar) |
| `supabase-schema.sql` | Cria as tabelas e as regras de segurança (RLS) |
| `migrar-dados.html` | Migra dados antigos do navegador para o banco (uso único) |
| `TUTORIAL.md` | **Guia completo de configuração e manutenção** |

## Como colocar no ar

Siga o **[TUTORIAL.md](TUTORIAL.md)** — passo a passo, do zero, sem precisar programar:

1. Criar projeto no Supabase
2. Rodar o `supabase-schema.sql`
3. Preencher o `config.js` com a URL e a chave `anon`
4. Criar os usuários
5. Publicar no GitHub Pages
6. Migrar os dados antigos

## Como os dados são salvos

- Cada operação (criar/editar/excluir) grava **apenas o registro afetado** no banco,
  então edições simultâneas de pessoas diferentes não se sobrescrevem.
- O `localStorage` é usado só como **cache de leitura** (offline somente-leitura).
- A chave `anon` no `config.js` é pública por design; a proteção real é o login + RLS.
