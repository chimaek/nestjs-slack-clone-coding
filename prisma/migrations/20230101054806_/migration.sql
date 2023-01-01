/*
  Warnings:

  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE `user`;

-- CreateTable
CREATE TABLE `channelchats` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `content` TEXT NOT NULL,
    `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `UserId` INTEGER NULL,
    `ChannelId` INTEGER NULL,

    INDEX `ChannelId`(`ChannelId`),
    INDEX `UserId`(`UserId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `channelmembers` (
    `ChannelId` INTEGER NOT NULL,
    `UserId` INTEGER NOT NULL,
    `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),

    INDEX `IDX_3446cc443ce59a7f7ae62acc16`(`UserId`),
    INDEX `IDX_e53905ed6170fb65083051881e`(`ChannelId`),
    INDEX `UserId`(`UserId`),
    PRIMARY KEY (`ChannelId`, `UserId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `channels` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    `private` BOOLEAN NULL DEFAULT false,
    `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `WorkspaceId` INTEGER NULL,

    INDEX `WorkspaceId`(`WorkspaceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `dms` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `content` TEXT NOT NULL,
    `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `WorkspaceId` INTEGER NULL,
    `SenderId` INTEGER NULL,
    `ReceiverId` INTEGER NULL,

    INDEX `WorkspaceId`(`WorkspaceId`),
    INDEX `dms_ibfk_2`(`SenderId`),
    INDEX `dms_ibfk_3`(`ReceiverId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mentions` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `category` ENUM('chat', 'dm', 'system') NOT NULL,
    `ChatId` INTEGER NULL,
    `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `WorkspaceId` INTEGER NULL,
    `SenderId` INTEGER NULL,
    `ReceiverId` INTEGER NULL,

    INDEX `ReceiverId`(`ReceiverId`),
    INDEX `SenderId`(`SenderId`),
    INDEX `WorkspaceId`(`WorkspaceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `migrations` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `timestamp` BIGINT NOT NULL,
    `name` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(30) NOT NULL,
    `nickname` VARCHAR(30) NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `deletedAt` DATETIME(6) NULL,

    UNIQUE INDEX `IDX_97672ac88f789774dd47f7c8be`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `workspacemembers` (
    `WorkspaceId` INTEGER NOT NULL,
    `UserId` INTEGER NOT NULL,
    `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `loggedInAt` DATETIME(0) NULL,

    INDEX `IDX_1f3af49b8195937f52d3a66e56`(`UserId`),
    INDEX `IDX_77afc26dfe5a8633e6ce35eaa4`(`WorkspaceId`),
    INDEX `UserId`(`UserId`),
    PRIMARY KEY (`WorkspaceId`, `UserId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `workspaces` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    `url` VARCHAR(30) NOT NULL,
    `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `updatedAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    `deletedAt` DATETIME(6) NULL,
    `OwnerId` INTEGER NULL,

    UNIQUE INDEX `IDX_de659ece27e93d8fe29339d0a4`(`name`),
    UNIQUE INDEX `IDX_22a04f0c0bf6ffd5961a28f5b7`(`url`),
    INDEX `OwnerId`(`OwnerId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `channelchats` ADD CONSTRAINT `FK_8494e7d49237c46d648fbab8cf4` FOREIGN KEY (`ChannelId`) REFERENCES `channels`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `channelchats` ADD CONSTRAINT `FK_d94a7a11d2bc17e56ed7c9790c3` FOREIGN KEY (`UserId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `channelmembers` ADD CONSTRAINT `FK_3446cc443ce59a7f7ae62acc168` FOREIGN KEY (`UserId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `channelmembers` ADD CONSTRAINT `FK_e53905ed6170fb65083051881e7` FOREIGN KEY (`ChannelId`) REFERENCES `channels`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `channels` ADD CONSTRAINT `FK_9fb12216c2d8cac3fad686e293b` FOREIGN KEY (`WorkspaceId`) REFERENCES `workspaces`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `dms` ADD CONSTRAINT `FK_904b6c6393befe39400ad9ff29c` FOREIGN KEY (`WorkspaceId`) REFERENCES `workspaces`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `dms` ADD CONSTRAINT `FK_ccb84506be7d2dcb3df1163e8ac` FOREIGN KEY (`ReceiverId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `dms` ADD CONSTRAINT `FK_e0b2f87fa1167f44f12aea6f5ca` FOREIGN KEY (`SenderId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `mentions` ADD CONSTRAINT `FK_51792a8377dc294a53b2bf7b213` FOREIGN KEY (`WorkspaceId`) REFERENCES `workspaces`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `mentions` ADD CONSTRAINT `FK_9cdbb618081d505406bde0e248e` FOREIGN KEY (`ReceiverId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `mentions` ADD CONSTRAINT `FK_f2a3d51cdda2918df6295336ebb` FOREIGN KEY (`SenderId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `workspacemembers` ADD CONSTRAINT `FK_1f3af49b8195937f52d3a66e566` FOREIGN KEY (`UserId`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `workspacemembers` ADD CONSTRAINT `FK_77afc26dfe5a8633e6ce35eaa44` FOREIGN KEY (`WorkspaceId`) REFERENCES `workspaces`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `workspaces` ADD CONSTRAINT `FK_d9a20240a57a1c75e626ef56b2f` FOREIGN KEY (`OwnerId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
