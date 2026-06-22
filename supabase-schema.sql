-- ============================================================
-- Sistema Jurídico — Wilquer Bosque
-- Esquema do banco de dados (Supabase / PostgreSQL)
-- ============================================================
-- Como usar: abra o painel do Supabase > SQL Editor > New query,
-- cole TODO este arquivo e clique em "Run". Roda uma vez só.
-- É seguro rodar de novo: usa "if not exists" / "drop policy if exists".
-- ============================================================

-- ------------------------------------------------------------
-- TABELAS
-- Estratégia: 1 linha por registro, conteúdo guardado em JSONB.
-- Isso mantém cada processo/prazo/suspensão independente (seguro
-- para 2 pessoas editarem ao mesmo tempo) e espelha exatamente
-- os objetos que o sistema já usa, sem precisar mapear campo a campo.
-- ------------------------------------------------------------

create table if not exists public.processos (
  id          text primary key,           -- mesmo id que o sistema gera (ex: "p1718900000000")
  data        jsonb not null,             -- o objeto do processo inteiro
  updated_at  timestamptz not null default now()
);

create table if not exists public.prazos (
  id          text primary key,           -- ex: "z1718900000000"
  data        jsonb not null,
  updated_at  timestamptz not null default now()
);

create table if not exists public.suspensoes (
  id          text primary key,           -- ex: "s1718900000000"
  data        jsonb not null,
  updated_at  timestamptz not null default now()
);

-- ------------------------------------------------------------
-- ROW LEVEL SECURITY (RLS)
-- Liga a "tranca": ninguém acessa nada sem estar logado.
-- Como os dados do escritório são compartilhados, a regra é:
-- qualquer usuário AUTENTICADO pode ler e gravar tudo.
-- Visitantes anônimos (sem login) não enxergam nada.
-- ------------------------------------------------------------

alter table public.processos  enable row level security;
alter table public.prazos     enable row level security;
alter table public.suspensoes enable row level security;

-- processos
drop policy if exists "auth_full_access" on public.processos;
create policy "auth_full_access" on public.processos
  for all
  to authenticated
  using (true)
  with check (true);

-- prazos
drop policy if exists "auth_full_access" on public.prazos;
create policy "auth_full_access" on public.prazos
  for all
  to authenticated
  using (true)
  with check (true);

-- suspensoes
drop policy if exists "auth_full_access" on public.suspensoes;
create policy "auth_full_access" on public.suspensoes
  for all
  to authenticated
  using (true)
  with check (true);

-- ------------------------------------------------------------
-- Pronto. Próximo passo: criar os usuários em
-- Authentication > Users (veja o TUTORIAL.md, passo 4).
-- ------------------------------------------------------------
