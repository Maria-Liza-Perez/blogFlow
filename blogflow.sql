-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2025 at 01:39 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blogflow`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `post_id`, `user_id`, `content`, `created_at`) VALUES
(79, 164, 46, 'Hiiii', '2025-11-29 11:35:47'),
(80, 164, 46, 'ee?', '2025-11-29 11:37:20'),
(83, 164, 61, 'Rochelleee', '2025-11-30 07:20:22'),
(84, 171, 59, 'Hoy admin', '2025-11-30 07:26:47'),
(85, 166, 59, 'pOGI NAMNA', '2025-11-30 10:20:53'),
(86, 166, 59, 'pa fs', '2025-11-30 10:21:05'),
(87, 166, 59, 'Pakiss arthur', '2025-11-30 10:36:36'),
(88, 171, 59, 'Kiss nga', '2025-11-30 10:38:03'),
(89, 171, 59, 'Ediwag', '2025-11-30 10:38:09'),
(90, 171, 59, 'What if?', '2025-11-30 10:58:07'),
(91, 171, 59, 'kiss', '2025-11-30 10:58:15'),
(92, 173, 61, 'Blehhhh', '2025-11-30 11:47:29'),
(93, 173, 61, 'Hey', '2025-11-30 11:47:36'),
(94, 172, 46, 'be?', '2025-11-30 16:21:58'),
(95, 182, 46, 'hello', '2025-11-30 16:30:46'),
(96, 182, 46, 'hmm', '2025-12-01 02:49:00'),
(98, 172, 61, 'ror', '2025-12-01 08:40:44');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `like_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`like_id`, `post_id`, `user_id`, `created_at`) VALUES
(119, 164, 59, '2025-11-29 10:54:22'),
(120, 164, 46, '2025-11-29 11:22:30'),
(123, 171, 46, '2025-11-30 02:42:49'),
(124, 164, 61, '2025-11-30 07:20:30'),
(125, 171, 59, '2025-11-30 07:26:51'),
(126, 166, 59, '2025-11-30 10:20:56'),
(127, 165, 61, '2025-11-30 11:42:32'),
(128, 173, 61, '2025-11-30 11:47:21'),
(134, 182, 46, '2025-12-01 02:49:07'),
(136, 181, 59, '2025-12-01 08:41:55'),
(137, 180, 59, '2025-12-01 08:41:57');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `actor_id` int(11) NOT NULL,
  `post_id` int(11) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `reply_id` int(11) DEFAULT NULL,
  `type` enum('like','comment','reply') NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `user_id`, `actor_id`, `post_id`, `comment_id`, `reply_id`, `type`, `message`, `is_read`, `created_at`) VALUES
(68, 61, 59, 171, 84, NULL, 'comment', 'commented on your post: Hoy admin', 1, '2025-11-30 07:26:47'),
(69, 61, 59, 171, NULL, NULL, 'like', 'liked your post', 1, '2025-11-30 07:26:51'),
(70, 61, 59, 166, 85, NULL, 'comment', 'commented on your post: pOGI NAMNA', 1, '2025-11-30 10:20:53'),
(71, 61, 59, 166, NULL, NULL, 'like', 'liked your post', 1, '2025-11-30 10:20:56'),
(72, 61, 59, 166, 86, NULL, 'comment', 'commented on your post: pa fs', 1, '2025-11-30 10:21:05'),
(73, 61, 59, 166, 87, NULL, 'comment', 'commented on your post: Pakiss arthur', 1, '2025-11-30 10:36:36'),
(74, 61, 59, 166, 85, 25, 'reply', 'replied to a comment on your post: hehehehhe', 1, '2025-11-30 10:36:49'),
(75, 61, 59, 171, 88, NULL, 'comment', 'commented on your post: Kiss nga', 1, '2025-11-30 10:38:03'),
(76, 61, 59, 171, 89, NULL, 'comment', 'commented on your post: Ediwag', 1, '2025-11-30 10:38:09'),
(77, 61, 59, 171, 90, NULL, 'comment', 'commented on your post: What if?', 1, '2025-11-30 10:58:07'),
(78, 61, 59, 171, 91, NULL, 'comment', 'commented on your post: kiss', 1, '2025-11-30 10:58:15'),
(79, 59, 61, 171, 91, 26, 'reply', 'replied to your comment: Pass', 1, '2025-11-30 11:42:20'),
(80, 59, 61, 173, NULL, NULL, 'like', 'liked your post: Hmmmm', 1, '2025-11-30 11:47:21'),
(81, 59, 61, 173, 92, NULL, 'comment', 'commented on your post: Blehhhh', 1, '2025-11-30 11:47:29'),
(82, 59, 61, 173, 93, NULL, 'comment', 'commented on your post: Hey', 1, '2025-11-30 11:47:36'),
(83, 59, 46, 172, 94, NULL, 'comment', 'commented on your post: be?', 1, '2025-11-30 16:21:58'),
(84, 46, 59, 172, 94, 27, 'reply', 'replied to your comment: oh?', 1, '2025-11-30 16:22:34'),
(87, 59, 61, 172, 98, NULL, 'comment', 'RochelleUchi commented on your post', 0, '2025-12-01 08:40:44'),
(88, 46, 59, 181, NULL, NULL, 'like', 'Rochelle liked your post', 0, '2025-12-01 08:41:55'),
(89, 46, 59, 180, NULL, NULL, 'like', 'Rochelle liked your post', 0, '2025-12-01 08:41:57');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `media_path` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `font_family` varchar(191) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `user_id`, `category`, `content`, `media_path`, `created_at`, `font_family`, `latitude`, `longitude`, `city`, `country`) VALUES
(164, 59, 'Technology', 'hihihi', '[\"public/uploads/images/1764405695_692ab1bfec446_flag.jpg\",\"public/uploads/images/1764405695_692ab1bfece1c_ict_2.jfif\",\"public/uploads/images/1764405695_692ab1bfed5b8_ICT_3.jfif\"]', '2025-11-29 08:41:38', 'Playfair Display', '14.6487853', '121.0509385', 'Quezon City', 'Philippines'),
(165, 61, 'Travel', 'Hello guys', '[\"public/uploads/images/1764427388_692b067cd9e40_ICT_3.jfif\",\"public/uploads/images/1764427388_692b067cda892_ICT.jfif\",\"public/uploads/images/1764427388_692b067cdb0c8_kingsize.jfif\"]', '2025-11-29 14:41:23', 'Poppins', '14.6487853', '121.0509385', 'Quezon City', 'Philippines'),
(166, 61, 'Travel', 'hihihii', '[\"public/uploads/images/1764427352_692b0658a5b9d_neri.jpg\"]', '2025-11-29 14:42:32', 'Roboto', '', '', NULL, NULL),
(168, 61, 'Lifestyle', 'Hello', '[\"public/uploads/images/1764463500_692b938cd97f1_flag.jpg\",\"public/uploads/images/1764463500_692b938cd9af7_ict_2.jfif\",\"public/uploads/images/1764463500_692b938cd9ce9_ICT_3.jfif\"]', '2025-11-30 00:45:00', 'Lora', '', '', NULL, NULL),
(171, 61, 'Food', 'hihhii', NULL, '2025-11-30 02:00:58', 'Roboto', '13.346648', '121.2531448', 'Calapan', 'Philippines'),
(172, 59, 'Food', 'What if?', '[]', '2025-11-30 11:44:13', 'Playfair Display', '14.1948762', '121.1597364', 'Calamba', 'Philippines'),
(173, 59, 'Technology', 'Hmmmm', '[\"public/uploads/images/1764503216_692c2eb013727_flag.jpg\",\"public/uploads/images/1764503216_692c2eb014946_ict_2.jfif\",\"public/uploads/images/1764503216_692c2eb014dd8_ICT_3.jfif\"]', '2025-11-30 11:46:58', 'Montserrat', '14.1948762', '121.1597364', 'Calamba', 'Philippines'),
(179, 46, 'Technology', 'luhhhh', '[]', '2025-11-30 16:14:29', 'Roboto', '', '', NULL, NULL),
(180, 46, 'Technology', 'what id', '[]', '2025-11-30 16:14:39', 'Roboto', '', '', NULL, NULL),
(181, 46, 'Lifestyle', 'try nga', '[]', '2025-11-30 16:14:52', 'Roboto', '', '', NULL, NULL),
(182, 46, 'Food', 'isa pa', NULL, '2025-11-30 16:15:05', 'Playfair Display', '', '', NULL, NULL),
(184, 59, 'Lifestyle', 'walang magawa', '[\"public/uploads/videos/1764578601_692d55290bd00_WIN_20251111_11_23_28_Pro.mp4\"]', '2025-12-01 08:43:21', 'Roboto', '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `replies`
--

CREATE TABLE `replies` (
  `reply_id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `replies`
--

INSERT INTO `replies` (`reply_id`, `comment_id`, `user_id`, `content`, `created_at`) VALUES
(24, 79, 46, 'what if?', '2025-11-29 11:37:11'),
(25, 85, 59, 'hehehehhe', '2025-11-30 10:36:49'),
(26, 91, 61, 'Pass', '2025-11-30 11:42:20'),
(27, 94, 59, 'oh?', '2025-11-30 16:22:34'),
(28, 95, 46, 'wait', '2025-12-01 02:49:16');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL DEFAULT 'user',
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `verification_code` varchar(10) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `role`, `password`, `created_at`, `verification_code`, `is_verified`) VALUES
(46, 'Reannnn', 'reannplacido2@gmail.com', 'user', '$2y$12$B2mtN6h297Zqk2BQchqQOOwqQ7Y1EPruaHxY70e41iFZnMp4prQFG', '2025-10-28 21:27:10', NULL, 1),
(59, 'Rochelle', 'rochelleuchi38@gmail.com', 'user', '$2y$12$Lp2b.qrvg/GdG4VJLJHIpuirDSzjzWhy/RdFvc4XpnkzZguB3yfeu', '2025-11-10 20:10:45', NULL, 1),
(61, 'RochelleUchi', 'grade12b.uchi.rochelle.suarez@gmail.com', 'admin', '$2y$12$9QkRG5/SoIOcq0.yYUU/a.C3wALcDScu9cEsDPSdaIdQztWPeUO8G', '2025-11-21 11:22:17', NULL, 1),
(62, 'deng', 'dreasy63@gmail.com', 'user', '$2y$12$uOPDX0c5W9SxCxs3WCCyuOIo3MK/IbON9EVeO5tbOj9gAkaW1Tike', '2025-11-21 13:10:10', '913053', 0),
(64, 'hihi', 'hihi@gmail.com', 'user', '$2y$12$oGOOxVe2Ub8B.3udkNFpdeJ7JayUv.vTJnl8KS5ccZ3YhVmKsstJC', '2025-11-22 23:35:15', '581127', 0),
(65, 'Reano', 'Reano@mail.com', 'user', '$2y$12$SVUqB2jgV8XEGyR6MWqHGet1xWoOX/pGsbQtrXdKHG4J.3CgBKlxi', '2025-11-26 12:38:26', '912498', 0),
(66, 'RochelleBa', 'gugu@gmail.com', 'user', '$2y$12$0My7YvVl2KXIv59fpX5hauKCvhWOYB755KcK/vxsFNUh2MdxyrSyC', '2025-11-26 12:44:56', '536036', 0),
(67, 'Fucku', 'fuc@gmail.com', 'user', '$2y$12$Ep9qTeQxs58Rs9Eh4SzCLetgm0Bw8UdrJVg3AXTFhCeeawVNnC0Xy', '2025-11-26 12:46:28', '940310', 0),
(68, 'Reanna', 'renana@gmail.com', 'user', '$2y$12$s7fJS5L.F6HP8kZP4lPCj.Kdn5yHxHb.1q1P0Rud6xZ0qNw6x80uG', '2025-11-26 12:55:27', '541227', 0),
(69, 'Karate', 'kara@gmail.com', 'user', '$2y$12$JZLpEWRaC6lSHh1Lk5D.t.EOS8.sbxo0H/K2kb1TGvsBW/db1Roey', '2025-11-26 12:59:42', '964705', 0),
(70, 'Halimaw', 'ha@gmail.com', 'user', '$2y$12$sRoKL/x/6PCLmBBKLf5rQOo95Fve3M6I6ZF7pIX1VKno5CBUtKXdy', '2025-11-26 13:00:10', '281501', 0),
(71, 'Pakk', 'p@gmail.com', 'user', '$2y$12$NPFVOR08Mxsf5Ca4eJ5TS.Rtfppp/aLATVLmh03Jv1K0Do0p89cpO', '2025-11-26 13:03:25', '798713', 0),
(72, 'RochelleUchii', 'rochelleuuchi38@gmail.com', 'user', '$2y$12$8rWqqkDwuvk9jCcta0.PeeL0.P9kn.Y.6hqW6LrvPZxXJGsCZPXIy', '2025-11-26 13:10:02', '663711', 0),
(73, 'Uchiii', 'rocheelleuchi38@gmail.com', 'user', '$2y$12$Apbw2YcRAl7683W3Vy/Y7eLdmabkZOs0Y5zg6HD8ckp5yLMAKGasq', '2025-11-26 13:14:51', NULL, 1),
(74, 'Harry', 'harry@gmail.com', 'user', '$2y$12$7pr3BTZHTygsPTRln4QoYejWqRQMlDsa8sB2y4MmLpdg0KmvCSbQq', '2025-11-28 23:09:33', NULL, 1),
(76, 'RochellePakiss', 'rochellepakiss@gmail.com', 'user', '$2y$12$KkoxrNSZ6qZVUib4dXUei.H0iZtfpFlnU8jXdukm3xWvaEOoPaPr6', '2025-11-29 14:45:45', NULL, 1),
(77, 'Jema', 'fabregaskenchie02@gmail.com', 'user', '$2y$12$TRijJK9UZ/utu99Ecy5bmuLLSoPGLYOZCKUXaT4iwmN7y3SYQ58VS', '2025-12-01 08:27:56', '256817', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`like_id`),
  ADD UNIQUE KEY `unique_like` (`post_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `actor_id` (`actor_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `reply_id` (`reply_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `replies`
--
ALTER TABLE `replies`
  ADD PRIMARY KEY (`reply_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `like_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=185;

--
-- AUTO_INCREMENT for table `replies`
--
ALTER TABLE `replies`
  MODIFY `reply_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_3` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_4` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_5` FOREIGN KEY (`reply_id`) REFERENCES `replies` (`reply_id`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `replies`
--
ALTER TABLE `replies`
  ADD CONSTRAINT `replies_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `replies_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
