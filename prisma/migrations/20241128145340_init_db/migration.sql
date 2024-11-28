-- CreateTable
CREATE TABLE "Jogador" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "email" TEXT,
    "dataCriacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dataAtualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Jogador_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Partida" (
    "id" TEXT NOT NULL,
    "data" TIMESTAMP(3) NOT NULL,
    "local" TEXT,
    "vencedorId" TEXT,
    "dataCriacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dataAtualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Partida_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PartidaJogador" (
    "jogadorId" TEXT NOT NULL,
    "partidaId" TEXT NOT NULL,

    CONSTRAINT "PartidaJogador_pkey" PRIMARY KEY ("jogadorId","partidaId")
);

-- CreateTable
CREATE TABLE "Estatisticas" (
    "id" TEXT NOT NULL,
    "jogadorId" TEXT NOT NULL,
    "partidasJogadas" INTEGER NOT NULL DEFAULT 0,
    "partidasVencidas" INTEGER NOT NULL DEFAULT 0,
    "setsVencidos" INTEGER NOT NULL DEFAULT 0,
    "pontosGanhos" INTEGER NOT NULL DEFAULT 0,
    "pontosPerdidos" INTEGER NOT NULL DEFAULT 0,
    "dataAtualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Estatisticas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ranking" (
    "id" TEXT NOT NULL,
    "jogadorId" TEXT NOT NULL,
    "posicao" INTEGER NOT NULL,
    "pontos" INTEGER NOT NULL,
    "dataAtualizacao" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Ranking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HistoricoDePontos" (
    "id" TEXT NOT NULL,
    "partidaId" TEXT NOT NULL,
    "jogadorId" TEXT NOT NULL,
    "setNumero" INTEGER NOT NULL,
    "pontos" INTEGER NOT NULL,

    CONSTRAINT "HistoricoDePontos_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Jogador_email_key" ON "Jogador"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Estatisticas_jogadorId_key" ON "Estatisticas"("jogadorId");

-- CreateIndex
CREATE UNIQUE INDEX "Ranking_jogadorId_key" ON "Ranking"("jogadorId");

-- CreateIndex
CREATE INDEX "HistoricoDePontos_partidaId_jogadorId_setNumero_idx" ON "HistoricoDePontos"("partidaId", "jogadorId", "setNumero");

-- AddForeignKey
ALTER TABLE "Partida" ADD CONSTRAINT "Partida_vencedorId_fkey" FOREIGN KEY ("vencedorId") REFERENCES "Jogador"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartidaJogador" ADD CONSTRAINT "PartidaJogador_jogadorId_fkey" FOREIGN KEY ("jogadorId") REFERENCES "Jogador"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartidaJogador" ADD CONSTRAINT "PartidaJogador_partidaId_fkey" FOREIGN KEY ("partidaId") REFERENCES "Partida"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Estatisticas" ADD CONSTRAINT "Estatisticas_jogadorId_fkey" FOREIGN KEY ("jogadorId") REFERENCES "Jogador"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ranking" ADD CONSTRAINT "Ranking_jogadorId_fkey" FOREIGN KEY ("jogadorId") REFERENCES "Jogador"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HistoricoDePontos" ADD CONSTRAINT "HistoricoDePontos_partidaId_fkey" FOREIGN KEY ("partidaId") REFERENCES "Partida"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HistoricoDePontos" ADD CONSTRAINT "HistoricoDePontos_jogadorId_fkey" FOREIGN KEY ("jogadorId") REFERENCES "Jogador"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
