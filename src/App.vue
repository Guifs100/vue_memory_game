<template>
  <div class="game">
    <h1>Jogo da Memória 🎮</h1>

    <div class="board">
      <Card
        v-for="(card, index) in cards"
        :key="card.id"
        :card="card"
        @flip="handleFlip(card)"
      />
    </div>

    <p>Tentativas: {{ tries }}</p>
    <button @click="resetGame" class="reset-button">Resetar Jogo</button>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import Card from './components/Card.vue'

interface CardData {
  id: number
  emoji: string
  flipped: boolean
  matched: boolean
}

const emojis: string[] = ['🐶', '🐱', '🐭', '🐹', '🐰', '🦊']
const cards = ref<CardData[]>([])
const flipped = ref<CardData[]>([])
const tries = ref(0)

function shuffle<T>(array: T[]): T[] {
  return array
    .map((item) => ({ item, sort: Math.random() }))
    .sort((a, b) => a.sort - b.sort)
    .map(({ item }) => item)
}

function initGame() {
  const pairCards = shuffle([...emojis, ...emojis]).map((emoji, index) => ({
    id: index,
    emoji,
    flipped: false,
    matched: false,
  }))
  cards.value = pairCards
  flipped.value = []
  tries.value = 0
}

function handleFlip(card: CardData) {
  if (flipped.value.length === 2 || card.flipped || card.matched) return

  card.flipped = true
  flipped.value.push(card)

  if (flipped.value.length === 2) {
    tries.value++
    const [first, second] = flipped.value

    if (first.emoji === second.emoji) {
      first.matched = true
      second.matched = true
      flipped.value = []
    } else {
      setTimeout(() => {
        first.flipped = false
        second.flipped = false
        flipped.value = []
      }, 1000)
    }
  }
}

function resetGame() {
  initGame()
}

onMounted(initGame)
</script>

<style scoped>
.game {
  text-align: center;
  font-family: sans-serif;
}

.board {
  display: grid;
  grid-template-columns: repeat(4, 100px);
  gap: 10px;
  justify-content: center;
  margin-top: 20px;
}

.reset-button {
  margin-top: 20px;
  padding: 10px 20px;
  font-size: 1rem;
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
}

.reset-button:hover {
  background-color: #45a049;
}
</style>
