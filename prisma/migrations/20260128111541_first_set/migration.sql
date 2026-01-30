-- CreateTable
CREATE TABLE `user` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(32) NULL,
    `passwordHash` VARCHAR(100) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `user_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `profile` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `fullName` VARCHAR(100) NULL,
    `avatarUrl` VARCHAR(100) NULL,
    `gender` VARCHAR(32) NULL,
    `country` VARCHAR(32) NULL,
    `language` VARCHAR(32) NULL,
    `timezone` VARCHAR(100) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `profile_userId_key`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `organization` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `baseCurrency` VARCHAR(100) NOT NULL,
    `timezone` VARCHAR(100) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `organizationMember` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `orgId` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,
    `role` VARCHAR(100) NOT NULL,
    `status` VARCHAR(100) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `organizationMember_userId_idx`(`userId`),
    INDEX `organizationMember_orgId_idx`(`orgId`),
    UNIQUE INDEX `organizationMember_orgId_userId_key`(`orgId`, `userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contacts` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `orgId` INTEGER NOT NULL,
    `entityType` VARCHAR(100) NOT NULL,
    `isVendor` BOOLEAN NOT NULL DEFAULT false,
    `isCustomer` BOOLEAN NOT NULL DEFAULT false,
    `displayName` VARCHAR(100) NOT NULL,
    `firstName` VARCHAR(100) NULL,
    `lastName` VARCHAR(100) NULL,
    `companyName` VARCHAR(100) NULL,
    `phone` VARCHAR(100) NULL,
    `email` VARCHAR(100) NULL,
    `taxId` VARCHAR(100) NULL,
    `billingAddress` VARCHAR(100) NULL,
    `shippingAddress` VARCHAR(100) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `contacts_orgId_idx`(`orgId`),
    UNIQUE INDEX `contacts_orgId_email_key`(`orgId`, `email`),
    UNIQUE INDEX `contacts_orgId_phone_key`(`orgId`, `phone`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `profile` ADD CONSTRAINT `profile_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `organizationMember` ADD CONSTRAINT `organizationMember_orgId_fkey` FOREIGN KEY (`orgId`) REFERENCES `organization`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `organizationMember` ADD CONSTRAINT `organizationMember_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `contacts` ADD CONSTRAINT `contacts_orgId_fkey` FOREIGN KEY (`orgId`) REFERENCES `organization`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
