// We should use https://www.npmjs.com/package/@cloudflare/workers-types
import { PrismaClient } from '@prisma/client/edge'

const prisma = new PrismaClient({})

async function getUsers() {
  console.debug(new Date(), "Start await prisma.$transaction")
  console.time('transactionTook');
  const data = await prisma.$transaction([
    prisma.user.findFirst(),
    prisma.user.findMany()
  ])
  console.timeEnd('transactionTook');
  console.debug(new Date(), "End await prisma.$transaction")

  const json = JSON.stringify({ data })

  return new Response(json, {
    status: 200,
    headers: {
      "content-type": "application/json;charset=UTF-8"
    }
  })
}

addEventListener("fetch", (event: FetchEvent) => {
  if (new URL(event.request.url).pathname === '/') {
    return event.respondWith(getUsers())
  }
})
