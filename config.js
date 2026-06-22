// ============================================================
// CONFIGURAÇÃO DO SUPABASE
// ============================================================
// Estes dois valores ligam o sistema ao seu banco no Supabase.
//
// ONDE PEGAR (veja o TUTORIAL.md, passo 3):
//   Painel do Supabase > Project Settings > Data API (ou "API")
//     - "Project URL"      -> cole em SUPABASE_URL
//     - "anon public" key  -> cole em SUPABASE_ANON_KEY
//
// É SEGURO deixar estes valores no código público:
//   - A URL é só o endereço do seu projeto.
//   - A chave "anon" foi feita para ficar no navegador. Quem protege
//     os dados de verdade é o login + as regras RLS do banco.
//   - NUNCA coloque aqui a chave "service_role" (essa é secreta).
// ============================================================

const SUPABASE_URL      = "https://fsgwueatosprjrguwpac.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_BMrtCR4naD-WbBtcUg5SRg_9vZkU72U";
