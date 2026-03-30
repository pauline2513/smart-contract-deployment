# Реализация смарт контракта (ERC-20)


 `StudentToken` — ERC-20 token
 
 `Subscription` — контракт реализации подписки сервиса

## Установка библиотек


- [Node.js](https://nodejs.org/) 
- [Truffle](https://trufflesuite.com/docs/truffle/getting-started/installation/)  
  ```bash
  npm install -g truffle
  ```
- [Ganache](https://trufflesuite.com/ganache/)

## Клонирование репозитория

```bash
git clone https://github.com/pauline2513/smart-contract-deployment.git
cd smart-contract-deployment
```

## Запуск Ganache

- Host: `127.0.0.1`
- Port: `7545`

## Компиляция и деплой

```bash
truffle compile --all
truffle migrate --reset --network development
```

## Запуск команд из CLI

```bash
truffle console --network development
```

Команды для тестирования
```javascript
const token = await StudentToken.deployed()
const sub = await Subscription.deployed()
const acc = await web3.eth.getAccounts()
(await token.balanceOf(acc[1])).toString()// вывод баланса в консоль для аккаунта с индексом 1
(await token.balanceOf(acc[0])).toString() // вывод баланса в консоль для аккаунта с индексом 0
await token.approve(sub.address, web3.utils.toWei("10", "ether"), { from: acc[1] })
await sub.paySubscription({ from: acc[1] })
(await token.balanceOf(acc[1])).toString() // вывод баланса в консоль для аккаунта с индексом 1
(await token.balanceOf(acc[0])).toString() // вывод баланса в консоль для аккаунта с индексом 0
(await sub.hasActiveSubscription(acc[1])) // проверка активной подписки у аккаунта с индексом 1
(await sub.hasActiveSubscription(acc[2])) // проверка активной подписки у аккаунта с индексом 2
```