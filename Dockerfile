FROM node:20-alpine as builder

WORKDIR /hagralli

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build


FROM node:20-alpine

WORKDIR /hagralli

COPY --from=builder /hagralli/.output ./.output

ENV PORT=3505
EXPOSE 3505

CMD ["node", ".output/server/index.mjs"]
