<template>
  <div class="card" @click="flipCard">
    <div class="inner" :class="{ flipped: card.flipped || card.matched }">
      <div class="front">?</div>
      <div class="back">{{ card.emoji }}</div>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  card: Object
})
const emit = defineEmits(['flip'])

function flipCard() {
  emit('flip')
}
</script>

<style scoped>
.card {
  width: 100px;
  height: 100px;
  cursor: pointer;
  perspective: 1000px;
}
.inner {
  width: 100%;
  height: 100%;
  transform-style: preserve-3d;
  transition: transform 0.5s;
  position: relative;
}
.inner.flipped {
  transform: rotateY(180deg);
}
.front, .back {
  position: absolute;
  width: 100%;
  height: 100%;
  font-size: 2rem;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #ccc;
  backface-visibility: hidden;
}
.front {
  background: #eee;
}
.back {
  background: white;
  transform: rotateY(180deg);
}
</style>
